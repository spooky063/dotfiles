# Packages

## Redshift
Réchauffe la température de l'écran selon l'heure
```
sudo apt update
sudo apt install redshift redshift-gtk
```

## Polybar
Gestionnaire de barre de status
```
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu yakkety-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
sudo apt update
sudo apt install polybar
```

Pour le configurer, utiliser le fichier de configuration fournis par défaut
```
sudo mkdir -p ~/.config/polybar
sudo cp /usr/share/doc/polybar/config ~/.config/polybar/
```

## Indicator multiload
Moniteur des ressources systèmes
```
sudo apt update
sudo apt install indicator-multiload
```

## Docker
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker ${USER}
```

## Docker Compose
```
wget -O - https://bit.ly/docker-install | bash

# If the previous command is not respond
sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)"
sudo chmod +x /usr/local/bin/docker-compose
```

## Git
```
sudo apt update
sudo apt install git
```

## Sublime Text
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text
```

## Spotify
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client
```

## Google Chrome
```
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```

## Firefox
```
sudo apt update
sudo apt install firefox firefox-locale-fr
```
