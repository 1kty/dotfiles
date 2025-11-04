#!/bin/bash
set -eu

WALL=$(realpath "$1")

echo "setting $WALL as wallpaper"
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$WALL"
hyprctl hyprpaper wallpaper ", $WALL"
cp -f "$WALL" "$HOME/.config/background"
echo "set $WALL as wallpaper sucessfully"

if command -v wal >/dev/null 2>&1; then
    echo "applying pywal colors..."
    wal -i "$WALL" --cols16 darken
    echo "pywal applied successfully"
    "$HOME/.config/mako/update-colors.sh"
else
    echo "pywal not installed, skipping"
fi
