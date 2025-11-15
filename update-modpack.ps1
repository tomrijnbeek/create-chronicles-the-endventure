# update-modpack.ps1
# Updater for tomrijnbeek/create-chronicles-the-endventure
# Place this file in the same folder as version.txt and the mod directories.
# The wrapper run-update.bat runs this script with ExecutionPolicy Bypass for one run.

$ErrorActionPreference = 'Stop'

function Write-Info { Write-Host "[*] $($args -join ' ')" }
function Write-OK   { Write-Host "[OK] $($args -join ' ')" -ForegroundColor Green }
function Write-Err  { Write-Host "[ERR] $($args -join ' ')" -ForegroundColor Red }

Write-Host "=== Chronicles: Orange-Flavoured Updater ==="

# Use script folder as base (works when launched from .bat or double-clicked)
$baseDir = Split-Path -Path $PSCommandPath -Parent
if (-not $baseDir) { $baseDir = Get-Location }  # fallback for interactive runs
Set-Location $baseDir

Write-Info "Working directory: $baseDir"

# 1. Read local version.txt
$versionFile = Join-Path $baseDir "version.txt"
if (Test-Path $versionFile) {
    $localVersion = (Get-Content $versionFile -Raw).Trim()
    Write-Info "Current installed version: $localVersion"
} else {
    Write-Info "version.txt not found — assuming no version installed."
    $localVersion = ""
}

# 2. Check latest release via GitHub API
$repo = "tomrijnbeek/create-chronicles-the-endventure"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"
Write-Info "Checking GitHub for latest release..."

try {
    $latest = Invoke-RestMethod -Uri $apiUrl -Headers @{ "User-Agent" = "UpdaterScript" } -UseBasicParsing
} catch {
    Write-Err "Failed to query GitHub API: $_"
    Read-Host "Press Enter to exit"
    exit 1
}

$latestVersion = $latest.tag_name
Write-Info "Latest release version: $latestVersion"

# 3. Compare versions
if ($localVersion -eq $latestVersion) {
    Write-OK "You already have the latest version ($localVersion). No update needed."
    Read-Host "Press Enter to exit"
    exit 0
}

Write-Info "Update available: $localVersion -> $latestVersion"

# 4. Find and download the release zip (artifact name pattern artifacts-<tag>.zip)
$asset = $latest.assets | Where-Object { $_.name -like "artifacts-*.zip" } | Select-Object -First 1

if (-not $asset) {
    Write-Err "Could not find an asset named artifacts-*.zip in the latest release assets."
    Read-Host "Press Enter to exit"
    exit 1
}

$downloadUrl = $asset.browser_download_url
$zipFile = Join-Path $baseDir "update-${latestVersion}.zip"

Write-Info "Downloading $($asset.name) ..."
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile -Headers @{ "User-Agent" = "UpdaterScript" }
} catch {
    Write-Err "Download failed: $_"
    Read-Host "Press Enter to exit"
    exit 1
}
Write-OK "Downloaded to $zipFile"

# 5. Delete current contents of the directories kubejs, mods, shaderpacks
$dirsToClear = @("kubejs", "mods", "shaderpacks")

foreach ($d in $dirsToClear) {
    $full = Join-Path $baseDir $d
    if (Test-Path $full) {
        Write-Info "Clearing directory: $d"
        try {
            # Remove all files and subdirectories but keep the directory itself
            Get-ChildItem -Path $full -Force -Recurse | Remove-Item -Force -Recurse -ErrorAction Stop
            Write-OK "Cleared $d"
        } catch {
            Write-Err "Failed to clear $d: $_"
            Read-Host "Press Enter to exit"
            exit 1
        }
    } else {
        Write-Info "Directory not found, skipping: $d"
    }
}

# 6. Extract archive on top of current directory (this will restore kubejs, mods, shaderpacks, config, etc.)
Write-Info "Extracting archive..."
try {
    # Expand-Archive will create files and overwrite existing ones when -Force used.
    Expand-Archive -Path $zipFile -DestinationPath $baseDir -Force
} catch {
    Write-Err "Extraction failed: $_"
    Read-Host "Press Enter to exit"
    exit 1
}
Write-OK "Extraction complete."

# 7. Update version.txt
Write-Info "Updating version.txt to $latestVersion"
try {
    Set-Content -Path $versionFile -Value $latestVersion -Encoding UTF8
    Write-OK "version.txt updated"
} catch {
    Write-Err "Failed to write version.txt: $_"
    Read-Host "Press Enter to exit"
    exit 1
}

# 8. Cleanup downloaded zip
Write-Info "Cleaning up temporary files..."
try {
    Remove-Item -Path $zipFile -Force
    Write-OK "Removed $zipFile"
} catch {
    Write-Err "Could not remove $zipFile: $_"
    # Not fatal, continue
}

Write-Host "`n=== Update complete! Installed version $latestVersion ==="
Read-Host "Press Enter to close"
