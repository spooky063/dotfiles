# Dotfile

Dépôt pour gérer les différents paquets a installer.
Utiliser les commandes make pour une gestion plus propre

```bash
cd ~
git clone https://github.com/Spooky063/dotfiles.git .dotfile
cd .dotfile
```

## Prérequis

```bash
# Ajout des dépots
sudo add-apt-repository -y ppa:git-core/ppa
```

## Utilisation des commandes

```bash
# Purge les paquets inutiles de l'installation de base
make apt.purge
```

```bash
# Mise à jour du système et installation des packets lors du premier lancement
make apt.update

# Met à jour les paquets
make apt.upgrade

# Installe les paquets au travers du manager apt
make apt
```

```bash
# Installe des paquets au travers du manager snap
make snap

# Met à jour les paquets
make snap.update
```

```bash
# Ajout de docker
make docker

# Ajout des outils docker
make docker-tools
```

```bash
# Installe le fichier de configuration pour vscode
make code-settings

# Installe les extensions
make code-extension
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
make shell.config
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
# Installation de composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
```

```bash
# Installation de nodejs && npm && npx
# Source : https://github.com/nodesource/distributions#installation-instructions
cd ~
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs gcc g++ make build-essential
```

```bash
# Installation de yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn
```

```bash
# Hide warning message for React/Angular hot-reloads files
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```
