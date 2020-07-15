#!/bin/bash

[ -x /usr/bin/wget ] || exit 0

wallpaper()
{
  [ ! -f /tmp/wallpaper.jpg ] || rm -f /tmp/wallpaper.jpg
  wget -qO /tmp/wallpaper.jpg https://unsplash.it/2560/1440/?random
  gsettings set org.gnome.desktop.background picture-uri file:///tmp/wallpaper.jpg
}

wallpaper

exit 0
