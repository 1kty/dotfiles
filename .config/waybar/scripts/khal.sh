#!/bin/bash

if hyprctl clients | grep -q "title: khal-popup"; then
	pkill -f "foot.*--title khal-popup";
	exit 0
fi

foot --title khal-popup bash -c "
script -qfc 'khal --color calendar' /dev/null | head -n 15
read -n 1
"
