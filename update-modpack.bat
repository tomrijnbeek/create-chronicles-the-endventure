@echo off
REM Run the PowerShell updater script in the same folder, bypassing execution policy for this process only.
REM Keeps the console open so you can read output.

cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0update-modpack.ps1"
pause
