#!/bin/bash
set -eu

if [ $# -lt 1 ]; then
    echo "Usage: $0 <wallpaper-path> [optional wal args...]"
    exit 1
fi

WALL=$(realpath "$1")
MONITOR=eDP-1

if [ ! -f "$WALL" ]; then
    echo "Error: file not found: $WALL"
    exit 1
fi

echo "Setting $WALL as wallpaper..."
qs -c noctalia-shell ipc call wallpaper set $WALL $MONITOR
cp -f "$WALL" "$HOME/.config/background"
echo "Set $WALL as wallpaper successfully"

