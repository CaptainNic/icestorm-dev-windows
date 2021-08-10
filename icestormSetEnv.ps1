$global:ProgressPreference = "SilentlyContinue"

$toolchainDir = "$PSScriptRoot/toolchain-icestorm"
$yosysPath = "$toolchainDir/bin/yosys.exe"
if (-Not (Test-Path -Path $yosysPath)) {
    $toolchainUri = "https://github.com/FPGAwars/toolchain-icestorm/releases/download/v1.11.1/toolchain-icestorm-windows_amd64-1.11.1.tar.gz"
    $zipFile = "$PSScriptRoot/toolchain-icestorm.zip"
    $dest = "$PSScriptRoot/toolchain-icestorm"
    Write-Host "icestorm toolchain not found, downloading..."
    Invoke-WebRequest -Uri $toolchainuri -OutFile $zipFile
    if (-Not $?) {
        Write-Warning "[FAILED] Unable to download toolchain."
        exit 1
    }

    Write-Host "Setting up toolchain directory..."
    if (-Not (Test-Path $toolchainDir)) {
        New-Item -Path $toolchainDir -ItemType Directory
    }
    Remove-Item "$toolchainDir/*" -Recurse -ErrorAction SilentlyContinue

    Write-Host "Unzipping toolchain package..."
    (tar -xzvf $zipFile -C $dest)
    if (-Not $?) {
        Write-Warning "[FAILED] Unable to unzip toolchain."
        exit 1
    }

    Write-Host "Verifying..."
    if (-Not (Test-Path -Path $yosysPath)) {
        Write-Warning "[FAILED] Toolchain downloaded and unzipped successfully, but still unable to find $yosysPath"
        exit 1
    }
}

Write-Host "Adding toolchain to PATH..."
$env:PATH = "${env:PATH};$PSScriptRoot/toolchain-icestorm/bin"
Write-Host "[DONE]"