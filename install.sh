#!/bin/bash

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
           wget -P font/. "https://objects.githubusercontent.com/github-production-release-asset-2e65be/27574418/b275015e-1259-4c0c-a952-a4d79e06fbf0?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230927%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230927T140753Z&X-Amz-Expires=300&X-Amz-Signature=71a14df05162b3faaf39d72fdc080ddd7109ab8c538a7bac155963a0371b2697&X-Amz-SignedHeaders=host&actor_id=33978801&key_id=0&repo_id=27574418&response-content-disposition=attachment%3B%20filename%3DIosevka.tar.xz&response-content-type=application%2Foctet-stream"
           wget -P font/. "https://objects.githubusercontent.com/github-production-release-asset-2e65be/27574418/23675e48-a286-47a6-ac4f-c703988097a2?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230927%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230927T140756Z&X-Amz-Expires=300&X-Amz-Signature=6ea93c38f1373db7a93f882e9b2b1279d8b495f6bdfe7f06f29139d28d6960ac&X-Amz-SignedHeaders=host&actor_id=33978801&key_id=0&repo_id=27574418&response-content-disposition=attachment%3B%20filename%3DIosevkaTerm.tar.xz&response-content-type=application%2Foctet-stream"
           tar -xf font/Iosevka.tar.xz -C Iosevka
           tar -xf font/IosevkaTerm.tar.xz -C IosevkaTerm
           cp -r font/Iosevka /usr/share/fonts/.
           cp -r font/IosevkaTerm /usr/share/fonts/.
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
