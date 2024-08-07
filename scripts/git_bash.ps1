# Script to install Git Bash

# Function to download files
function Download-File {
    param(
        [string]$url,
        [string]$output
    )
    Invoke-WebRequest -Uri $url -OutFile $output
}

# Temporary directory to store installers
$TempDir = "$env:TEMP\installers"
New-Item -ItemType Directory -Path $TempDir -Force

# Git Bash
Write-Host "Downloading and installing Git Bash..."
$GitBashUrl = "https://github.com/git-for-windows/git/releases/download/v2.39.0.windows.1/Git-2.39.0-64-bit.exe"
$GitBashInstaller = "$TempDir\gitbash.exe"
Download-File -url $GitBashUrl -output $GitBashInstaller
Start-Process -FilePath $GitBashInstaller -ArgumentList "/SILENT" -Wait
Write-Host "Git Bash installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force
