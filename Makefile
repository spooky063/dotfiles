current_dir = $(shell pwd)

.PHONY: apt apt.update apt.upgrade apt.purge snap snap-stable snap-classic snap.update package.update docker docker-tools compose ctop code-settings code-extension code-extension.uninstall omf omf.config shell.config vundle wallpaper

## PACKAGE

apt:
	cat packages/apt.list | xargs -n 1 sudo apt install -y

apt.update:
	sudo apt update -y
	cat packages/apt.list | xargs -n 1 sudo apt install -y
	sudo apt autoclean
	sudo apt autoremove

apt.upgrade:
	sudo apt update -y
	sudo apt upgrade
	sudo apt autoclean -y
	sudo apt autoremove -y

apt.purge:
	cat packages/purge.list | xargs -n 1 sudo apt-get purge

snap: snap-stable snap-classic

snap-stable:
	cat packages/snap.list | xargs -n 1 sudo snap install

snap-classic:
	cat packages/snap-classic.list | xargs -n 1 sudo snap install --classic

snap.update:
	sudo snap refresh

package.update: apt.update snap.update

## SOFTWARE

docker:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io
	sudo usermod -aG docker ${USER}

docker-tools: compose ctop

compose:
	/bin/bash ./scripts/compose.sh

ctop:
	/bin/bash ./scripts/ctop.sh

code-settings:
	rm -f ~/.config/Code/User/settings.json
	ln -s ${current_dir}/config/code/settings.json ~/.config/Code/User/settings.json

code-extension:
	jq '."extension-manager.extensions"[]' ${current_dir}/config/code/settings.json | xargs -L 1 code --install-extension

code-extension.uninstall:
	code --list-extensions | xargs -L 1 code --uninstall-extension

## SHELL

.SILENT: omf
omf:
	echo "For omf installation, launch the following command: \033[0;33mcurl -L https://get.oh-my.fish | fish\e[0m"

omf.config:
	/bin/bash ./config/omf.sh

shell.config:
	/bin/bash ./config/config.sh

vundle:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

## UI

wallpaper:
	/bin/bash ./scripts/wallpaper.sh
	sudo ln -s ${current_dir}/scripts/wallpaper.sh /etc/rc.local
