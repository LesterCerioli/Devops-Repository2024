# Script to install Visual Studio Code

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

# Visual Studio Code
Write-Host "Downloading and installing Visual Studio Code..."
$VSCodeUrl = "https://update.code.visualstudio.com/latest/win32-x64/stable"
$VSCodeInstaller = "$TempDir\vscode.exe"
Download-File -url $VSCodeUrl -output $VSCodeInstaller
Start-Process -FilePath $VSCodeInstaller -ArgumentList "/silent /mergetasks=!runcode" -Wait
Write-Host "Visual Studio Code installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force
