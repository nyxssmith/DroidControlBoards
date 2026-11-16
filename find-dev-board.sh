#!/bin/bash

get_devices() {
    local devs=()
    for d in /dev/ttyACM* /dev/ttyS*; do
        [[ -e "$d" ]] && devs+=("$d")
    done
    echo "${devs[@]}"
}

# Snapshot devices before plugging in the board
read -ra before <<< "$(get_devices)"

echo "Current serial devices:" >&2
if [[ ${#before[@]} -eq 0 ]]; then
    echo "  (none)" >&2
else
    for d in "${before[@]}"; do
        echo "  $d" >&2
    done
fi

echo "" >&2
echo "Hold down the BOOT button on your dev board, plug it in via USB, then release." >&2
read -rp "Press Enter when ready..." </dev/tty

# Poll for a new device to appear (up to 15 seconds)
echo "Waiting for new device..." >&2
SELECTED=""
for i in $(seq 1 30); do
    read -ra after <<< "$(get_devices)"
    for d in "${after[@]}"; do
        found=false
        for b in "${before[@]}"; do
            [[ "$d" == "$b" ]] && found=true && break
        done
        if ! $found; then
            SELECTED="$d"
            break 2
        fi
    done
    sleep 0.5
done

if [[ -z "$SELECTED" ]]; then
    echo "" >&2
    echo "No new serial device detected after 15 seconds." >&2
    echo "Current devices:" >&2
    for d in "${after[@]}"; do
        echo "  $d" >&2
    done
    exit 1
fi

echo "" >&2
echo "New device detected: $SELECTED" >&2
echo "$SELECTED"
