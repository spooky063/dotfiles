current_dir = $(shell pwd)

.PHONY: purge pat snap snap-stable snap-classic docker docker-tools compose ctop omf omf-install config vundle

purge:
	cat packages/purge.list | xargs -n 1 sudo apt-get purge

apt:
	sudo apt update -y
	cat packages/apt.list | xargs -n 1 sudo apt install -y
	sudo apt autoclean
	sudo apt autoremove

apt-update:
	sudo apt update -y
	sudo apt upgrade
	sudo apt autoclean -y
	sudo apt autoremove -y

snap: snap-stable snap-classic

snap-stable:
	cat packages/snap.list | xargs -n 1 sudo snap install

snap-classic:
	cat packages/snap-classic.list | xargs -n 1 sudo snap install --classic

snap-update:
	sudo snap refresh

update: apt-update snap-update 

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

.SILENT: omf
omf:
	echo "For omf installation, launch the following command: \033[0;33mcurl -L https://get.oh-my.fish | fish\e[0m"

omf-install:
	/bin/bash ./config/omf.sh

config:
	/bin/bash ./config/config.sh

vundle:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

wallpaper:
	/bin/bash ./scripts/wallpaper.sh
	sudo ln -s ${current_dir}/scripts/wallpaper.sh /etc/rc.local
