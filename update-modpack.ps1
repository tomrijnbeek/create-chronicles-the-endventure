# --- Update Modpack Script ---
# This script checks the latest GitHub release and installs it locally

$ErrorActionPreference = "Stop"

Write-Host "=== Chronicles: Orange Flavoured Updater ==="

# -------------------------------
# 1. Read local version.txt
# -------------------------------
$versionFile = "version.txt"

if (Test-Path $versionFile) {
    $localVersion = Get-Content $versionFile -Raw
    Write-Host "Current installed version: $localVersion"
} else {
    Write-Host "version.txt not found — assuming no version installed."
    $localVersion = ""
}

# -------------------------------
# 2. Get latest GitHub release
# -------------------------------
$repo = "tomrijnbeek/create-chronicles-the-endventure"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"

Write-Host "Checking GitHub for latest release…"

# GitHub API requires a User-Agent
$latest = Invoke-RestMethod -Uri $apiUrl -Headers @{ "User-Agent" = "UpdaterScript" }

$latestVersion = $latest.tag_name
Write-Host "Latest release version: $latestVersion"

# -------------------------------
# 3. Compare versions
# -------------------------------
if ($localVersion -eq $latestVersion) {
    Write-Host "You already have the latest version. No update needed."
    Start-Sleep 3
    exit
}

Write-Host "Update available! Preparing to download…"

# -------------------------------
# 4. Download the release zip
# -------------------------------
$asset = $latest.assets | Where-Object { $_.name -like "artifacts-*.zip" }

if (-not $asset) {
    Write-Host "ERROR: Could not find release artifact zip file!"
    exit 1
}

$downloadUrl = $asset.browser_download_url
$zipFile = "update.zip"

Write-Host "Downloading $($asset.name)…"
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile -Headers @{ "User-Agent" = "UpdaterScript" }

Write-Host "Download complete."

# -------------------------------
# 5. Delete directories
# -------------------------------
$dirsToClear = @("kubejs", "mods", "shaderpacks")

foreach ($d in $dirsToClear) {
    if (Test-Path $d) {
        Write-Host "Clearing directory: $d"
        Remove-Item "$d/*" -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# -------------------------------
# 6. Extract archive
# -------------------------------
Write-Host "Extracting update.zip…"

# Expand-Archive overwrites with -Force
Expand-Archive -Path $zipFile -DestinationPath "." -Force

Write-Host "Extraction complete."

# -------------------------------
# 7. Update version.txt
# -------------------------------
Write-Host "Updating version.txt…"
Set-Content -Path $versionFile -Value $latestVersion

# -------------------------------
# 8. Cleanup
# -------------------------------
Write-Host "Cleaning up…"
Remove-Item $zipFile -Force

Write-Host "`n=== Update complete! Installed version $latestVersion ==="
Start-Sleep 5
