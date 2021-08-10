# icestorm-dev-windows
Project for bootstrapping the icestorm FPGA toolchain on Windows.

### Environment Setup
Run `icestormSetEnv.ps1`, this will download the win64 icestorm toolchain from https://github.com/FPGAwars/toolchain-icestorm/releases (if not already installed) and add the directory to your PATH.

`yosys` and friends will now be available from the commandline.

Run `Build-IceStick.ps1 test/Spiral.v` to build the blinkenlights test program and flash it to your icestick.
