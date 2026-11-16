#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check that esptool is available
if ! command -v esptool.py &>/dev/null && ! command -v esptool &>/dev/null; then
    echo "esptool not found in PATH."
    echo "Activate your virtual environment and install it:"
    echo "  source venv/bin/activate"
    echo "  pip install esptool"
    exit 1
fi

# Check for a .bin file in the current directory
bin_file=$(find . -maxdepth 1 -name "*.bin" | head -n 1)

if [[ -z "$bin_file" ]]; then
    echo "No .bin file found. Running get-firmware.sh..."
    bash "$SCRIPT_DIR/get-firmware.sh" || { echo "get-firmware.sh failed."; exit 1; }
    bin_file=$(find . -maxdepth 1 -name "*.bin" | head -n 1)
    if [[ -z "$bin_file" ]]; then
        echo "Still no .bin file found after running get-firmware.sh. Aborting."
        exit 1
    fi
fi

echo "Using firmware: $bin_file"
echo ""

# Detect the dev board serial port
DEVICE=$(bash "$SCRIPT_DIR/find-dev-board.sh") || exit 1

echo ""
echo "Dev board serial port: $DEVICE"


# erease flash to ensure a clean slate for flashing firmware
esptool --chip esp32s3 --port "$DEVICE" erase_flash

# flash firmware to the board
esptool --chip esp32s3 --port "$DEVICE" --baud 460800 write_flash -z 0x0 "$bin_file"