# Script to install Go

# Function to add environment variables
function Add-Path {
    param(
        [string]$Path
    )
    [Environment]::SetEnvironmentVariable('Path', $env:Path + ";$Path", [EnvironmentVariableTarget]::Machine)
}

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

# Go
Write-Host "Downloading and installing Go..."
$GoUrl = "https://golang.org/dl/go1.20.3.windows-amd64.msi"
$GoInstaller = "$TempDir\go.msi"
Download-File -url $GoUrl -output $GoInstaller
Start-Process msiexec.exe -ArgumentList "/i $GoInstaller /quiet /norestart" -Wait
Add-Path "C:\Program Files\Go\bin"
Write-Host "Go installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force
