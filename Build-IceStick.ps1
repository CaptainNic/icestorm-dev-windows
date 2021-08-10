param (
    [Parameter(Mandatory)]
    [String]
    $Main
)

$global:ErrorActionPreference = "Stop"

# Call setenv if toolchain is not in PATH
if (-Not (Get-Command "yosys" -ErrorAction SilentlyContinue)) {
    "$PSScriptRoot\icestormSetEnv.ps1"
}

yosys -p "synth_ice40 -blif $Main.blif" $Main
if (-Not $?) {
    Write-Warning "[FAILED] yosys"
    exit 1
}

arachne-pnr -d 1k -p "$PSScriptRoot/pcf/icestick.pcf" "$Main.blif" -o "$Main.txt"
if (-Not $?) {
    Write-Warning "[FAILED] arachne-pnr"
    exit 1
}

icepack "$Main.txt" "$Main.bin"
if (-Not $?) {
    Write-Warning "[FAILED] icepack"
    exit 1
}

iceprog "$Main.bin"
if (-Not $?) {
    Write-Warning "[FAILED] iceprog"
    exit 1
}