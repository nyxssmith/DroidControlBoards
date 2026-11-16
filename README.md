# Droid Control Boards

Each directory is a separate Droid Control Board project.
Each project contains the necessary code and configuration to control a specific type of droid.

The main directory contains scripts to flash boards.

# Get firmware from micropython

https://micropython.org/download/ESP32_GENERIC_S3/

Find the latest firmware for the ESP32_GENERIC_S3 board on the Micropython website and update `get-firmware.sh` with the new URL.

Running that script will download the latest firmware for the ESP32*GENERIC*\_S3 board.

Next, run `flash-dev-board.sh` to flash the downloaded firmware onto your ESP32_GENERIC_S3 board once its plugged in with usb.

Once the firmware is flashed, you can use `run-file.sh`, `upload-file.sh`, and `set-main-file.sh` to manage files on your ESP32_GENERIC_S3 board.

Run file will just run the one piece of code.
The board will run any file named `main.py` automatically on startup, which is what `set-main-file.sh` is used to configure.
`upload-file.sh` is used to upload files to the board, allowing you to add or update code and resources.
