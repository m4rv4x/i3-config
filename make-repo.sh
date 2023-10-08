#!/bin/bash
date=$(date +"%d%m%y%H%M")
if [ -d "$date" ]; then
    echo "Folder already exists. Exiting..."
    exit 1
fi

mkdir "$date"
mkdir "$date/config"
mkdir "$date/home"

config_dirs=("i3" "polybar" "rofi" "gtk-2.0" "gtk-3.0" "gtk-4.0")

for dir in "${config_dirs[@]}"; do
    if [ -d ~/.config/"$dir" ]; then
        cp -r ~/.config/"$dir" "$date/config/."
    else
        echo "Config folder for $dir does not exist. Skipping..."
    fi
done

home_files=(".gtkrc-2.0" ".fehbg" ".xbindkeysrc" ".Xmodmap")

for file in "${home_files[@]}"; do
    if [ -f ~/"$file" ]; then
        cp ~/"$file" "$date/home/."
    else
        echo "Config file $file does not exist. Skipping..."
    fi
done
