#!/usr/bin/env bash

DCONF_FILE="$HOME/.config/dconf/gnome-settings.conf"

echo Importing GNOME settings...
dconf load / < "$DCONF_FILE"

echo Enabling GDM...
sudo systemctl enable --now gdm.service