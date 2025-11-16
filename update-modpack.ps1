# update-modpack.ps1
# Updater for tomrijnbeek/create-chronicles-the-endventure
# Place this file in the same folder as version.txt and the mod directories.

$ErrorActionPreference = 'Stop'

function Write-Info { Write-Host "[*] $($args -join ' ')" }
function Write-OK   { Write-Host "[OK] $($args -join ' ')" -ForegroundColor Green }
function Write-Err  { Write-Host "[ERR] $($args -join ' ')" -ForegroundColor Red }

Write-Host "=== Create Chronicles: Orange Flavoured Updater ==="

# Determine script directory reliably
$baseDir = if ($PSScriptRoot) { $PSScriptRoot } elseif ($PSCommandPath) { Split-Path -Path $PSCommandPath -Parent } else { Get-Location }
Set-Location $baseDir

Write-Info "Working directory: $baseDir"

# 1) Read local version
$versionFile = Join-Path $baseDir "version.txt"
if (Test-Path $versionFile) {
    $localVersion = (Get-Content $versionFile -Raw).Trim()
    Write-Info "Current installed version: $localVersion"
} else {
    Write-Info "version.txt not found - assuming no version installed."
    $localVersion = ""
}

# 2) Query GitHub latest release
$repo = "tomrijnbeek/create-chronicles-the-endventure"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"

Write-Info "Checking GitHub for latest release..."
try {
    $latest = Invoke-RestMethod -Uri $apiUrl -Headers @{ "User-Agent" = "UpdaterScript" }
} catch {
    Write-Err "Failed to query GitHub API: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}

$latestVersion = $latest.tag_name
Write-Info "Latest release version: $latestVersion"

# 3) Compare versions
if ($localVersion -eq $latestVersion) {
    Write-OK "You already have the latest version ($localVersion)."
    Read-Host "Press Enter to exit"
    exit 0
}

Write-Info "Update available: $localVersion -> $latestVersion"

# 4) Find and download the artifacts zip (pattern artifacts-*.zip)
$asset = $latest.assets | Where-Object { $_.name -like "artifacts-*.zip" } | Select-Object -First 1
if (-not $asset) {
    Write-Err "No artifacts-*.zip asset found in latest release."
    Read-Host "Press Enter to exit"
    exit 1
}

$downloadUrl = $asset.browser_download_url
$zipFile = Join-Path $baseDir ("update-" + $latestVersion + ".zip")

Write-Info "Downloading asset: $($asset.name)"

function Download-File {
    param(
        [Parameter(Mandatory=$true)] [string] $Url,
        [Parameter(Mandatory=$true)] [string] $OutFile
    )

    # Try BITS first (often more reliable / resumable on Windows)
    if (Get-Command Start-BitsTransfer -ErrorAction SilentlyContinue) {
        try {
            Write-Info "Using Start-BitsTransfer..."
            # remove any existing partial file
            if (Test-Path $OutFile) { Remove-Item -Path $OutFile -Force -ErrorAction SilentlyContinue }
            Start-BitsTransfer -Source $Url -Destination $OutFile -DisplayName "ModpackDownload" -ErrorAction Stop
            Write-OK "Downloaded to: $OutFile (via BITS)"
            return $true
        } catch {
            Write-Info "Start-BitsTransfer failed, falling back: $($_.Exception.Message)"
        }
    } else {
        Write-Info "Start-BitsTransfer not available, falling back to HttpClient."
    }

    # Fallback: streamed HttpClient download to avoid loading whole response in memory
    try {
        $start = Get-Date
        $handler = New-Object System.Net.Http.HttpClientHandler
        $handler.AutomaticDecompression = [System.Net.DecompressionMethods]::GZip -bor [System.Net.DecompressionMethods]::Deflate
        $http = New-Object System.Net.Http.HttpClient($handler)
        $http.DefaultRequestHeaders.UserAgent.ParseAdd("UpdaterScript")
        $resp = $http.GetAsync($Url, [System.Net.Http.HttpCompletionOption]::ResponseHeadersRead).GetAwaiter().GetResult()
        $resp.EnsureSuccessStatusCode()

        $stream = $resp.Content.ReadAsStreamAsync().GetAwaiter().GetResult()
        $fileStream = [System.IO.File]::Create($OutFile)
        $buffer = New-Object byte[] 65536
        $total = 0
        while (($read = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $fileStream.Write($buffer, 0, $read)
            $total += $read
        }
        $fileStream.Close()
        $stream.Close()
        $resp.Dispose()
        $http.Dispose()

        $elapsed = (Get-Date) - $start
        $seconds = [Math]::Max($elapsed.TotalSeconds, 0.001)
        $mbits = ($total * 8) / 1MB
        $mbps = [Math]::Round($mbits / $seconds, 2)
        Write-OK "Downloaded to: $OutFile (size: $([Math]::Round($total/1MB,2)) MB, avg: $mbps Mbit/s)"
        return $true
    } catch {
        Write-Err "Download failed: $($_.Exception.Message)"
        return $false
    }
}

try {
    if (-not (Download-File -Url $downloadUrl -OutFile $zipFile)) {
        throw "All download methods failed."
    }
} catch {
    Write-Err "Download failed: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}
Write-OK "Downloaded to: $zipFile"

# 5) Delete current contents of kubejs, mods, shaderpacks (keep folders)
$dirsToClear = @("kubejs", "mods", "shaderpacks")
foreach ($d in $dirsToClear) {
    $full = Join-Path $baseDir $d
    if (Test-Path $full) {
        Write-Info "Clearing contents of: $d"
        try {
            if ($d -ieq "shaderpacks") {
                # Only remove .zip files; keep .zip.txt and other files/folders
                $zips = Get-ChildItem -Path $full -Filter "*.zip" -File -Recurse -Force -ErrorAction Stop
                if ($zips) {
                    $zips | Remove-Item -Force -ErrorAction Stop
                    Write-OK "Cleared .zip files in $d"
                } else {
                    Write-Info "No .zip files found in $d"
                }
            } else {
                # Remove child items but keep the directory itself
                Get-ChildItem -Path $full -Force -Recurse | Remove-Item -Force -Recurse -ErrorAction Stop
                Write-OK "Cleared $d"
            }
        } catch {
            Write-Err "Failed to clear ${d}: $($_.Exception.Message)"
            Read-Host "Press Enter to exit"
            exit 1
        }
    } else {
        Write-Info "Directory not present, skipping: $d"
    }
}

# 6) Extract the archive into current directory (will overwrite files)
Write-Info "Extracting archive..."
try {
    Expand-Archive -Path $zipFile -DestinationPath $baseDir -Force
} catch {
    Write-Err "Extraction failed: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}
Write-OK "Extraction complete."

# 7) Update version.txt
Write-Info "Updating version.txt to $latestVersion"
try {
    Set-Content -Path $versionFile -Value $latestVersion -Encoding UTF8
    Write-OK "version.txt updated"
} catch {
    Write-Err "Failed to update version.txt: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}

# 8) Cleanup
Write-Info "Cleaning up downloaded zip..."
try {
    Remove-Item -Path $zipFile -Force
    Write-OK "Removed $zipFile"
} catch {
    Write-Err "Could not delete ${zipFile}: $($_.Exception.Message)"
    # non-fatal
}

Write-Host ""
Write-OK "Update complete! Installed version $latestVersion"
Read-Host "Press Enter to close"
