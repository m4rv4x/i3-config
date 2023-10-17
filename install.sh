#!/bin/bash

# Install DEPENDENCIES
if ! dpkg -s wget >/dev/null 2>&1; then
  sudo apt install wget -y
fi

# Install DEPENDENCIES
if ! dpkg -s i3 i3blocks i3lock i3status i3-wm polybar rofi dex >/dev/null 2>&1; then
  sudo apt install i3 i3blocks i3lock i3status i3-wm polybar rofi dex -y
fi

# Install BACKGROUND AND COMPOSITE
if ! dpkg -s feh compton mate-background >/dev/null 2>&1; then
  sudo apt install feh compton mate-background -y
fi

# Install Tray Apps
if ! dpkg -s pasystray nm-tray diodon >/dev/null 2>&1; then
  sudo apt install pasystray nm-tray diodon -y
fi

# Select Config with DIALOG
	# Get the list of folders containing only numeric characters
	folders=$(find . -maxdepth 1 -type d -name '[0-9]*' -printf "%f\n")

	# Check if any folders are found
	if [[ -z $folders ]]; then
	  echo "No folders containing only numeric characters found."
	  exit 1
	fi

	# Prompt the user to choose a folder
	selected_folder=$(dialog --menu "Choose a config:" 10 40 3 $(
	  for folder in $folders; do
	    echo "$folder -"
	  done
	) 2>&1 >/dev/tty)

	# Check if the user canceled the selection
	if [[ -z $selected_folder ]]; then
	  echo "Folder selection canceled."
	  exit 1
	fi

	# Print the selected folder
	echo "Selected folder: $selected_folder"

# Download COPY FONT AWESOME IOSEVKA 
	# Verify if Iosevka font exists
	if [[ ! -f /usr/share/fonts/iosevka ]]; then
	  mkdir font
	  echo "Do you want to download the Iosevka font? (y/N)"
	  read -r response
	  if [[ $response == "y" ]]; then
          wget "https://fontesk.com/download/20494/" -O font/iosevka.zip
          unzip font/iosevka.zip -d font/iosevka
          sudo cp -r font/iosevka /usr/share/fonts/.
	  fi
	fi

# Copy CONFIG (gtk + i3 + polybar + rofi)
echo "Do you want to copy the gtk, i3, polybar, and rofi config files? (y/N)"
read -r response
if [[ $response == "y" ]]; then
  cp -f -i -r $selected_folder/config/* ~/.config
fi

# Copy CONFIG (.fehbg + xbindkeysrc + Xmodmap)
echo "Do you want to copy the .fehbg, xbindkeysrc, and Xmodmap files? (y/N)"
read -r response
if [[ $response == "y" ]]; then
  cp -f -i -r $selected_folder/home/* ~/.
fi

echo "[!] i3 theme install done"
