# Script to install Go, JDK 17, Python 3.12, .NET 8 SDK and Runtime, Visual Studio Code, Git Bash, Ruby, Node.js 20, Opera, and Firefox

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

# JDK 17
Write-Host "Downloading and installing JDK 17..."
$JDKUrl = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"
$JDKInstaller = "$TempDir\jdk17.exe"
Download-File -url $JDKUrl -output $JDKInstaller
Start-Process -FilePath $JDKInstaller -ArgumentList "/s" -Wait
Add-Path "C:\Program Files\Java\jdk-17\bin"
Write-Host "JDK 17 installed successfully!"

# Python 3.12
Write-Host "Downloading and installing Python 3.12..."
$PythonUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
$PythonInstaller = "$TempDir\python312.exe"
Download-File -url $PythonUrl -output $PythonInstaller
Start-Process -FilePath $PythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Write-Host "Python 3.12 installed successfully!"

# .NET 8 SDK
Write-Host "Downloading and installing .NET 8 SDK..."
$DotNetSdkUrl = "https://download.visualstudio.microsoft.com/download/pr/xyz/dotnet-sdk-8.0.100-win-x64.exe"
$DotNetSdkInstaller = "$TempDir\dotnetsdk8.exe"
Download-File -url $DotNetSdkUrl -output $DotNetSdkInstaller
Start-Process -FilePath $DotNetSdkInstaller -ArgumentList "/quiet" -Wait
Write-Host ".NET 8 SDK installed successfully!"

# .NET 8 Runtime
Write-Host "Downloading and installing .NET 8 Runtime..."
$DotNetRuntimeUrl = "https://download.visualstudio.microsoft.com/download/pr/xyz/dotnet-runtime-8.0.0-win-x64.exe"
$DotNetRuntimeInstaller = "$TempDir\dotnetruntime8.exe"
Download-File -url $DotNetRuntimeUrl -output $DotNetRuntimeInstaller
Start-Process -FilePath $DotNetRuntimeInstaller -ArgumentList "/quiet" -Wait
Write-Host ".NET 8 Runtime installed successfully!"

# Visual Studio Code
Write-Host "Downloading and installing Visual Studio Code..."
$VSCodeUrl = "https://update.code.visualstudio.com/latest/win32-x64/stable"
$VSCodeInstaller = "$TempDir\vscode.exe"
Download-File -url $VSCodeUrl -output $VSCodeInstaller
Start-Process -FilePath $VSCodeInstaller -ArgumentList "/silent /mergetasks=!runcode" -Wait
Write-Host "Visual Studio Code installed successfully!"

# Git Bash
Write-Host "Downloading and installing Git Bash..."
$GitBashUrl = "https://github.com/git-for-windows/git/releases/download/v2.39.0.windows.1/Git-2.39.0-64-bit.exe"
$GitBashInstaller = "$TempDir\gitbash.exe"
Download-File -url $GitBashUrl -output $GitBashInstaller
Start-Process -FilePath $GitBashInstaller -ArgumentList "/SILENT" -Wait
Write-Host "Git Bash installed successfully!"

# Ruby
Write-Host "Downloading and installing Ruby..."
$RubyUrl = "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.0-1/rubyinstaller-devkit-3.1.0-1-x64.exe"
$RubyInstaller = "$TempDir\rubyinstaller.exe"
Download-File -url $RubyUrl -output $RubyInstaller
Start-Process -FilePath $RubyInstaller -ArgumentList "/verysilent" -Wait
Add-Path "C:\Ruby31-x64\bin"
Write-Host "Ruby installed successfully!"

# Node.js 20
Write-Host "Downloading and installing Node.js 20..."
$NodeJsUrl = "https://nodejs.org/dist/v20.0.0/node-v20.0.0-x64.msi"
$NodeJsInstaller = "$TempDir\nodejs.msi"
Download-File -url $NodeJsUrl -output $NodeJsInstaller
Start-Process msiexec.exe -ArgumentList "/i $NodeJsInstaller /quiet /norestart" -Wait
Write-Host "Node.js 20 installed successfully!"

# Opera
Write-Host "Downloading and installing Opera..."
$OperaUrl = "https://net.geo.opera.com/opera/stable/windows"
$OperaInstaller = "$TempDir\opera.exe"
Download-File -url $OperaUrl -output $OperaInstaller
Start-Process -FilePath $OperaInstaller -ArgumentList "/silent /allusers" -Wait
Write-Host "Opera installed successfully!"

# Firefox
Write-Host "Downloading and installing Firefox..."
$FirefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$FirefoxInstaller = "$TempDir\firefox.exe"
Download-File -url $FirefoxUrl -output $FirefoxInstaller
Start-Process -FilePath $FirefoxInstaller -ArgumentList "/S" -Wait
Write-Host "Firefox installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force

Write-Host "Installation completed!"
