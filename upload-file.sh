#!/usr/bin/env bash
set -euo pipefail

if ! command -v mpremote &>/dev/null; then
    echo "Error: mpremote not found in PATH." >&2
    echo "Install it and activate your venv, e.g.:" >&2
    echo "  source .venv/bin/activate" >&2
    exit 1
fi

if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo "Usage: $(basename "$0") <source-file> <destination-on-device> [device]" >&2
    echo "  e.g.: $(basename "$0") main.py :main.py" >&2
    echo "  e.g.: $(basename "$0") main.py :main.py /dev/ttyACM2" >&2
    exit 1
fi

set -ex
src="$1"
dst="$2"
device="${3:-a1}"

if [[ "$device" == "a"* ]]; then
    mpremote "$device" cp "$src" :"$dst"
else
    mpremote connect "$device" -- cp "$src" :"$dst"
fi
