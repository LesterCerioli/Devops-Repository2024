# Script to install Python 3.12

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

# Python 3.12
Write-Host "Downloading and installing Python 3.12..."
$PythonUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
$PythonInstaller = "$TempDir\python312.exe"
Download-File -url $PythonUrl -output $PythonInstaller
Start-Process -FilePath $PythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Write-Host "Python 3.12 installed successfully!"

# Clean up temporary directory
Remove-Item -Path $TempDir -Recurse -Force
