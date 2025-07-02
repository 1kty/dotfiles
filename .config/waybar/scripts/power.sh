#!/bin/bash

choice=$(echo -e "Shutdown\nReboot\nSuspend\nLock\nLogout" | tofi --font /usr/share/fonts/TTF/JetBrainsMonoNL-Regular.ttf)

case "$choice" in
	"Shutdown") systemctl poweroff ;;
	"Reboot") systemctl reboot ;;
	"Suspend") systemctl suspend ;;
	"Lock") loginctl lock-session ;;
	"Logout") pkill -KILL -u $USER ;;
esac
