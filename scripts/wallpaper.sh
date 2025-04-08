#!/bin/bash

[ -x /usr/bin/wget ] || exit 0

dir='/tmp/wallpaper.jpg'

unsplash()
{
  wget -qO ${dir} "https://unsplash.it/2560/1440/?random"
}

bing() {
  wget -qO ${dir} "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"
}

bing
gsettings set org.gnome.desktop.background picture-uri file://${dir}

exit 0
