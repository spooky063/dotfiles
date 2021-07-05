#!/bin/bash

[ -x /usr/bin/wget ] || exit 0

unsplash()
{
  wget -qO /tmp/wallpaper.jpg "https://unsplash.it/2560/1440/?random"
}

bing() {
  wget -qO /tmp/wallpaper.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"
}

bing
gsettings set org.gnome.desktop.background picture-uri file:////tmp/wallpaper.jpg

exit 0
