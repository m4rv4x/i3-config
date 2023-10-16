# i3 Tokyo Theme (beta)

- Original Theme : https://github.com/stronk-dev/Tokyo-Night-Linux

- Automated install : just run `install.sh`

## i3 Shortcuts

- ⌘ + Enter = New Terminal
- ⌘ + BackSpace = Firefox

- ⌘ + D = Rofi Launcher
- ⌘ + P = Rofi SSH Launcher
- ⌘ + O = Rofi File Search

- ⌘ + A = Select Multiple Window
- ⌘ + Q = Kill Active Window
- ⌘ + Z = Focus w/ Horizontal tabs
- ⌘ + S = Focus w/ Horizontal tabs
- ⌘ + E = Unfocus w/ Vert-Horiz Switch
- ⌘ + F = Fullscreen

- ⌘ + [0-10] = Change to desktop
- ⌘ + Shift + [0-10] = Move active window to desktop
- ⌘ + Shift + R = Restart i3
- ⌘ + Shift + C = Reload i3

## polybar


## rofi


## font
[Iosevka](https://typeof.net/Iosevka/)

Download : https://github.com/be5invis/Iosevka/releases/download/v27.2.0/super-ttc-iosevka-27.2.0.zip

## feh (wallpaper)

mate wallpapers

## dependencies

run `install.sh`

## icons
[Tokyo Night-SE](
https://github.com/ljmill/tokyo-night-icons)

Download : https://github.com/ljmill/tokyo-night-icons/releases/download/v0.2.0/TokyoNight-SE.tar.bz2


## Help
Copying files

All the files go into your home directory, except for:

    /etc/logid.conf
    /usr/share/themes/TokyoNight

If using polybar-themes, install it from the original source first to get all their dependencies and fonts. Then you can overwrite their files with the included ones.
Apply Theme

    GTK: Run lxappearance and/or gnome-tweaks and select the included theme

    GDM: Run gnomeconf2gdm (from gdm-tools-git) after applying the GTK theme to set the colour scheme of the login screen

Notes

    GDM does not start .xinitrc . If you are using I3, it is easier to just type in startx after logging in
    Certain GTK programs, like Gimp and Firefox, might have to be set to follow the system theme from their settings
    A modified version of console-solarized-git is coming in order to modify the Linux shell colours to match our theme.

