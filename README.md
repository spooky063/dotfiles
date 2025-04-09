# Dotfile

Repository for managing the different packages to install.
Use the make commands for a more proper management.

```bash
cd ~
git clone https://github.com/Spooky063/dotfiles.git .dotfile
cd .dotfile
```

## Prerequisites

```bash
sudo add-apt-repository -y ppa:git-core/ppa
```

## Commands

```bash
# Purge all unused packages
make apt.purge
```

```bash
# Update the system and install the packages at the first launch
make apt.update

# Update packages
make apt.upgrade

# Install package through the manager apt
make apt
```

```bash
# Install package through the manager snap
make snap

# Refresh snap packages
make snap.update
```

```bash
# Add docker
make docker

# Add extra tools for docker (docker-compose standalone, ctop)
make docker-tools
```

```bash
# Add lazygit
make lazygit
```

```bash
## You can just connect to your github account or you can launch the command
## -------------------------------------------------------------------------

# Install the settings for code software
make code-settings

# Install plugins for code software
make code-plugin
```

```bash
# Oh my Fish!
rm -rf ~/.local/share/omf/

make omf
# OR

curl -L https://get.oh-my.fish | fish
omf theme default
omf install godfather
```

```bash
# Add shell configuration files
make shell.config
```

```bash
# Vim configuration
make vundle
```

```bash
# Install the theme 'Aura' for terminal
make term-theme
```

```bash
# Add the bing wallpaper on startup
make wallpaper
```

```bash
# Add the toggle light/dark button on startup
make ui-toggle-light-dark
```

```bash
# Add the Geist Mono font
make font-geist
```

## Software

### Libre office

You can install it via the official website: https://www.libreoffice.org/download/download-libreoffice

### Obsidian

You can install it via the official website: https://obsidian.md/download

### Brave

> Source: https://brave.com/linux/#debian-ubuntu-mint

```bash
sudo apt install curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
```

### Charles

If you looking for a proxy tool, you can install Charles: https://www.charlesproxy.com/

## Development tool (optional)

### Composer

> Source: https://getcomposer.org/download/

```bash
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
```

### Nodejs && npm && npx

> Source: https://github.com/nodesource/distributions#installation-instructions

```bash
cd ~
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs gcc g++ make build-essential
```

### Yarn

> Source: https://yarnpkg.com/getting-started/install

```bash
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn
```

## Shell tools (optional)

### Bashtop

> Source: https://github.com/aristocratos/bashtop

```bash
# Bashtop
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update
sudo apt install bashtop
```

## Troubleshooting

### Hide warning message for React/Angular hot-reloads files

```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```