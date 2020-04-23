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

make omf OR curl -L https://get.oh-my.fish | fish

omf theme default
omf install godfather
```

```bash
# Ajout des fichiers de configuration du système
make config
```
