#!/bin/bash

if hyprctl clients | grep -q "title: floatterm"; then
	pkill -f "foot.*--title floatterm";
	exit 0
fi

foot --title floatterm bash -c "btop"
