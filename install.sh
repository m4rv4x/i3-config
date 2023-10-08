#!/bin/bash

# Refresh Package list
sudo apt update

# Install DEPENDENCIES
if ! dpkg -s i3 i3blocks i3lock i3status i3-wm polybar rofi dex xmodmap >/dev/null 2>&1; then
  sudo apt install i3 i3blocks i3lock i3status i3-wm polybar rofi dex xmodmap -y
fi

# Install BACKGROUND AND COMPOSITE
if ! dpkg -s feh compton mate-background >/dev/null 2>&1; then
  sudo apt install feh compton mate-background -y
fi

# Install Tray Apps
if ! dpkg -s pasystray nm-applet diodon >/dev/null 2>&1; then
  sudo apt install pasystray nm-applet diodon -y
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
	if [[ ! -f /usr/share/fonts/iosevka.ttc ]]; then
	  mkdir font
	  echo "Do you want to download the Iosevka font? (y/n)"
	  read -r response
	  if [[ $response == "y" ]]; then
	    wget -O font/. https://github.com/be5invis/Iosevka/releases/download/v27.2.0/super-ttc-iosevka-27.2.0.zip
	    unzip font/super-ttc-iosevka-27.2.0.zip
	    sudo cp font/iosevka.ttc /usr/share/fonts/.
	  fi
	fi

# Copy CONFIG (gtk + i3 + polybar + rofi)
echo "Do you want to copy the gtk, i3, polybar, and rofi config files? (y/n)"
read -r response
if [[ $response == "y" ]]; then
  cp -i -r $selected_folder/config/* ~/.config
fi

# Copy CONFIG (.fehbg + xbindkeysrc + Xmodmap)
echo "Do you want to copy the .fehbg, xbindkeysrc, and Xmodmap files? (y/n)"
read -r response
if [[ $response == "y" ]]; then
  cp -i -r $selected_folder/home/* ~/.
fi

echo "[!] i3 theme install done"