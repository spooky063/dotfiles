#!/bin/bash

set -x

light() {
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    gsettings set org.gnome.desktop.interface icon-theme 'ubuntu-mono-light'
}

dark() {
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.interface icon-theme 'ubuntu-mono-dark'
}

current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)

if [ "$current_theme" = "'Adwaita-dark'" ]; then
    light
else
    dark
fi