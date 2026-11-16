#!/usr/bin/env bash
set -euo pipefail

if ! command -v mpremote &>/dev/null; then
    echo "Error: mpremote not found in PATH." >&2
    echo "Install it and activate your venv, e.g.:" >&2
    echo "  source .venv/bin/activate" >&2
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: $(basename "$0") <source-file>" >&2
    echo "  e.g.: $(basename "$0") main.py" >&2
    exit 1
fi

set -ex
src="$1"

mpremote a1 cp "$src" :main.py
