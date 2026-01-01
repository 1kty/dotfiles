#!/bin/bash
set -eu

if [ $# -lt 1 ]; then
    echo "Usage: $0 <wallpaper-path> [optional wal args...]"
    exit 1
fi

WALL=$(realpath "$1")

if [ ! -f "$WALL" ]; then
    echo "Error: file not found: $WALL"
    exit 1
fi

echo "Setting $WALL as wallpaper..."
swww img --transition-type=fade --transition-duration=2 "$WALL"
cp -f "$WALL" "$HOME/.config/background"
echo "Set $WALL as wallpaper successfully"

if command -v wal >/dev/null 2>&1; then
    echo "Applying pywal colors..."
    if ! wal -i "$WALL" --cols16 darken "${@:2}" 2>/dev/null; then
        echo "Primary wal backend failed, trying colorthief..."
        wal -i "$WALL" --cols16 darken --backend colorthief "${@:2}"
    fi
    echo "Pywal applied successfully"
    "$HOME/.config/mako/update-colors.sh"
else
    echo "Pywal not installed, skipping"
fi
