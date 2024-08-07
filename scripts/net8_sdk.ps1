# Script to install .NET 8 SDK

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

# .NET 8 SDK
Write-Host "Downloading and installing .NET 8 SDK..."
$DotNetSdkUrl = "https://download.visualstudio.microsoft.com/download/pr/xyz/dotnet-sdk-8.0.100-win-x64.exe"
$DotNetSdkInstaller = "$TempDir\dotnetsdk8.exe"
Download-File -url $DotNetSdkUrl -output $DotNetSdkInstaller
Start-Process -FilePath $DotNetSdkInstaller -ArgumentList "/quiet" -Wait
Write-Host ".NET 8 SDK installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force
