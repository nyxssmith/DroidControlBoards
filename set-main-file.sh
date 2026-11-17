#!/usr/bin/env bash
set -euo pipefail

if ! command -v mpremote &>/dev/null; then
    echo "Error: mpremote not found in PATH." >&2
    echo "Install it and activate your venv, e.g.:" >&2
    echo "  source .venv/bin/activate" >&2
    exit 1
fi

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: $(basename "$0") <source-file> [device]" >&2
    echo "  e.g.: $(basename "$0") main.py" >&2
    echo "  e.g.: $(basename "$0") main.py /dev/ttyACM2" >&2
    exit 1
fi

set -ex
src="$1"
device="${2:-a1}"

if [[ "$device" == "a"* ]]; then
    mpremote "$device" cp "$src" :main.py
else
    mpremote connect "$device" -- cp "$src" :main.py
fi
