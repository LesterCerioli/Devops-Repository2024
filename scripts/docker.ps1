# Script to install Docker Desktop on Windows and configure necessary features

# Function to download files
function Download-File {
    param(
        [string]$url,
        [string]$output
    )
    Write-Host "Downloading file from $url to $output..."
    Invoke-WebRequest -Uri $url -OutFile $output
}

# Configure necessary features for Docker
Write-Host "Enabling required Windows features..."

# Enable WSL (Windows Subsystem for Linux)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Enable Virtual Machine Platform
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Enable Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart

# Prompt for reboot if necessary
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -eq "Enabled" -and `
    (Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform).State -eq "Enabled" -and `
    (Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All).State -eq "Enabled") {
    Write-Host "Necessary features enabled. Restart your computer to apply the changes."
    Read-Host "Press Enter after restarting your computer to continue with the Docker Desktop installation."
}

# Install Docker Desktop
Write-Host "Downloading and installing Docker Desktop..."
$dockerUrl = "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe"
$dockerInstaller = "$env:TEMP\DockerDesktopInstaller.exe"

Download-File -url $dockerUrl -output $dockerInstaller

Write-Host "Running Docker Desktop installer..."
Start-Process -FilePath $dockerInstaller -ArgumentList "install" -Wait

# Verify Docker installation
Write-Host "Verifying Docker Desktop installation..."
Start-Sleep -Seconds 10

# Check if Docker is installed correctly
if (Get-Command docker -ErrorAction SilentlyContinue) {
    Write-Host "Docker Desktop installed successfully."
} else {
    Write-Host "Docker Desktop installation failed. Check the logs and try again."
}

# Clean up installation file
Remove-Item -Path $dockerInstaller -Force

Write-Host "Installation and configuration complete!"
