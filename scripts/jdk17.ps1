# Script to install JDK 17

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

# JDK 17
Write-Host "Downloading and installing JDK 17..."
$JDKUrl = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"
$JDKInstaller = "$TempDir\jdk17.exe"
Download-File -url $JDKUrl -output $JDKInstaller
Start-Process -FilePath $JDKInstaller -ArgumentList "/s" -Wait
Add-Path "C:\Program Files\Java\jdk-17\bin"
Write-Host "JDK 17 installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force
