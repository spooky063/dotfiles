# Dotfile

Dépôt pour gérer les différents paquets a installer.  
Utiliser les commandes make pour une gestion plus propre

```bash
cd ~
git clone https://github.com/Spooky063/dotfiles.git .dotfile
cd .dotfile
```

## Utilisation des commandes

```bash
# Purger les paquets inutiles de l'installation de base
make purge
```

```bash
# Ajout des paquets au travers du manager apt
make apt
```

```bash
# Ajout des paquets au travers du manager snap
make snap
```

```bash
# Ajout de docker
make docker

# Ajout des outils docker
make docker-tools
```

```bash
# Ajout de Oh my Fish!
rm -rf ~/.local/share/omf/

make omf
# OR
curl -L https://get.oh-my.fish | fish
omf theme default
omf install godfather
```

```bash
# Ajout des fichiers de configuration du système
make config
```

```bash
# Configuration de vim
make vundle
```

```bash
# Ajout d'un wallpaper custom à chaque démarrage
make wallpaper
```

## Outils de développement supplémentaire (optional)

```bash
# Installation de nodejs && npm && npx
cd ~
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs gcc g++ make
rm -rf nodesource_setup.sh
```

```bash
# Installation de yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn -y
```

```bash
# Hide warning message for React/Angular hot-reloads files
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```
