# Script to install Ruby, set up the environment variable, and install Ruby on Rails

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
    Write-Host "Downloading file from $url to $output..."
    Invoke-WebRequest -Uri $url -OutFile $output
}

# Temporary directory to store installers
$TempDir = "$env:TEMP\installers"
Write-Host "Creating temporary directory at $TempDir..."
New-Item -ItemType Directory -Path $TempDir -Force

# Ruby
Write-Host "Downloading and installing Ruby..."
$RubyUrl = "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.0-1/rubyinstaller-devkit-3.1.0-1-x64.exe"
$RubyInstaller = "$TempDir\rubyinstaller.exe"
Download-File -url $RubyUrl -output $RubyInstaller
Write-Host "Running Ruby installer..."
Start-Process -FilePath $RubyInstaller -ArgumentList "/verysilent" -Wait
Write-Host "Ruby installed successfully."

# Adding Ruby to Path
$RubyPath = "C:\Ruby31-x64\bin"
Write-Host "Setting up environment variable for Ruby..."
Add-Path -Path $RubyPath

# Verify Ruby installation
Write-Host "Verifying Ruby installation..."
$rubyVersion = & $RubyPath\ruby.exe -v
Write-Host "Ruby version $rubyVersion installed successfully."

# Install Ruby on Rails
Write-Host "Installing Ruby on Rails..."
gem install rails

# Verify Rails installation
Write-Host "Verifying Ruby on Rails installation..."
$railsVersion = & $RubyPath\rails.exe -v
Write-Host "Ruby on Rails version $railsVersion installed successfully."

# Clean up temporary directory
Write-Host "Cleaning up temporary directory..."
Remove-Item -Path $TempDir -Recurse -Force

Write-Host "Installation and configuration completed!"
