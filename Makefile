current_dir = $(shell pwd)

HELP_FUN = \
    %help; \
    while(<>) { \
        if(/^([\w@.-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2 // 'options'}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target]\n\n"; \
    for ( sort keys %help ) { \
        print "$$_:\n"; \
        printf("\033[36m  %-20s %s\033[0m\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

.PHONY: apt apt.update apt.upgrade apt.purge snap snap-stable snap-classic snap.update package.update docker docker-tools compose ctop lazygit code-settings code-plugin code-plugin.remove omf omf.config shell.config vundle term-theme wallpaper ui-toggle-light-dark

help:
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

## PACKAGE
apt: ##@package Installs all the packages with apt
	cat packages/apt.list | xargs -n 1 sudo apt install -y

apt.update: ##@package Updates all the packages with apt
	sudo apt update -y
	cat packages/apt.list | xargs -n 1 sudo apt install -y
	sudo apt autoclean
	sudo apt autoremove

apt.upgrade: ##@package Upgrades all the packages with apt
	sudo apt update -y
	sudo apt upgrade
	sudo apt autoclean -y
	sudo apt autoremove -y

apt.purge: ##@package Purges all the packages with apt
	cat packages/purge.list | xargs -n 1 sudo apt-get purge -y
	sudo apt autoremove -y

snap: snap-stable snap-classic ##@package Installs all the packages with snap

snap-stable: ##@package Installs all the packages with snap
	cat packages/snap.list | xargs -n 1 sudo snap install

snap-classic: ##@package Installs all the classic packages with snap
	cat packages/snap-classic.list | xargs -n 1 sudo snap install --classic

snap.update: ##@package Updates all the packages with snap
	sudo snap refresh

package.update: apt.update snap.update ##@package Update all the packages

docker: ##@software Installs docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io
	sudo usermod -aG docker ${USER}

docker-tools: compose ctop ##@software Installs docker-tools

compose: ##@software Installs docker-compose
	/bin/bash ./scripts/compose.sh

ctop: ##@software Installs ctop
	/bin/bash ./scripts/ctop.sh

lazygit: ##@software Installs lazygit
	/bin/bash ./scripts/lazygit.sh

code-settings: ##@software Installs code settings
	rm -f ~/.config/Code/User/settings.json
	ln -s ${current_dir}/config/code/settings.json ~/.config/Code/User/settings.json

code-plugin: ##@software Installs code extensions
	jq '."extension-manager.extensions"[]' ${current_dir}/config/code/settings.json | xargs -L 1 code --install-extension

code-plugin.remove: ##@software Uninstalls code extensions
	code --list-extensions | xargs -L 1 code --uninstall-extension

.SILENT: omf
omf: ##@shell Installs oh-my-fish
	echo "For omf installation, launch the following command: \033[0;33mcurl -L https://get.oh-my.fish | fish\e[0m"

omf.config: ##@shell Installs oh-my-fish config
	/bin/bash ./config/omf.sh

shell.config: ##@shell Installs shell config
	/bin/bash ./config/config.sh

vundle: ##@shell Installs vim plugins
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

term-theme: ##@shell Installs terminal theme
	/bin/bash ./scripts/aura-terminal/aura-terminal.sh

wallpaper: ##@ui Installs wallpaper
	/bin/bash ./scripts/wallpaper.sh
	sudo ln -s ${current_dir}/scripts/wallpaper.sh /etc/rc.local

ui-toggle-light-dark: ##@ui Installs toggle light/dark button
	sudo apt install python3-gi gir1.2-appindicator3-0.1
	cp scripts/toggle-light-dark-button/light-dark-launcher.sh /usr/local/bin/light-dark-launcher.sh
	cp scripts/toggle-light-dark-button/light-dark-switcher.py /usr/local/bin/light-dark-switcher.py
	chmod +x /usr/local/bin/light-dark-switcher.py
	nohup /usr/local/bin/light-dark-switcher.py &
	mkdir -p ~/.config/autostart
	cp scripts/toggle-light-dark-button/light-dark-entry.desktop ~/.config/autostart/light-dark-entry.desktop

font-geist: ##@font Install Geist Mono
	/bash/bin ./scripts/font.sh
	sudo fc-cache -fv