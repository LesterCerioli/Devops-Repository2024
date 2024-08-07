# Script to download and install Google Chrome, Firefox, and Opera

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

# Google Chrome
Write-Host "Downloading and installing Google Chrome..."
$ChromeUrl = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463c-AFF1-A69D9E530F96%7D%26iid%3D%7B9B2DDA15-F335-65EB-7B14-7A5C707003C1%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dx64-stable/dl/chrome/install/googlechromestandaloneenterprise64.msi"
$ChromeInstaller = "$TempDir\chrome.msi"
Download-File -url $ChromeUrl -output $ChromeInstaller
Write-Host "Running Google Chrome installer..."
Start-Process msiexec.exe -ArgumentList "/i $ChromeInstaller /quiet /norestart" -Wait
Write-Host "Google Chrome installed successfully."

# Firefox
Write-Host "Downloading and installing Firefox..."
$FirefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$FirefoxInstaller = "$TempDir\firefox.exe"
Download-File -url $FirefoxUrl -output $FirefoxInstaller
Write-Host "Running Firefox installer..."
Start-Process -FilePath $FirefoxInstaller -ArgumentList "/S" -Wait
Write-Host "Firefox installed successfully."

# Opera
Write-Host "Downloading and installing Opera..."
$OperaUrl = "https://net.geo.opera.com/opera/stable/windows"
$OperaInstaller = "$TempDir\opera.exe"
Download-File -url $OperaUrl -output $OperaInstaller
Write-Host "Running Opera installer..."
Start-Process -FilePath $OperaInstaller -ArgumentList "/silent /allusers" -Wait
Write-Host "Opera installed successfully."

# Clean up temporary directory
Write-Host "Cleaning up temporary directory..."
Remove-Item -Path $TempDir -Recurse -Force

Write-Host "Browser installation completed!"
