#!/bin/bash

# Colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

# Git URL base
gitRaw="https://raw.githubusercontent.com/Spooky063/start-desk/master/"


####################################################################
#                                                                  #
#            FUNCTIONS                                             #
#                                                                  #
####################################################################
create_directory() {
	if ! [ -d "$1" ];
	then
		mkdir -p "$1"
		echo "${GREEN}Le dossier '$1' a été créé.${RESET}"
	fi
}

init() {
	checkDependencies
	addConfigurationFile
	addGITConfiguration
	addVIMConfiguration
	addDockerConfiguration
}

####################################################################
#                                                                  #
#            DEPENDENCIES                                          #
#                                                                  #
####################################################################
checkDependencies() {
	declare -A dependencies
	dependencies=( [cURL]="curl" [vim]="vim" [GIT]="git")

	for i in "${!dependencies[@]}"
	do
		if [ -x "curl" ]; 
		then
			echo "${RED}You should install $i before continue...${RESET}"
			exit;
		fi
	done
}

####################################################################
#                                                                  #
#            CONFIGURATION FILE                                    #
#                                                                  #
####################################################################
addConfigurationFile() {
	# Configuration basic files
	declare -A filesConfig
	filesConfig=( [.bash_aliases]="$HOME/.bash_aliases" \
		      [.bashrc]="$HOME/.bashrc" \
		      [.gitconfig]="$HOME/.gitconfig" \
		      [.tmux.conf]="$HOME/.tmux.conf" \
		      [.vimrc]="$HOME/.vimrc" \
	)

	# Install configuration file
	echo "Démarrage de l'installation des fichiers de configuration..."
	for i in "${!filesConfig[@]}"
	do
		if [ -f "${filesConfig[$i]}" ]; 
		then
			# Backup current file
			cp ${filesConfig[$i]} ${filesConfig[$i]}.old
		fi

		# Get file and apply modification
		curl -so ${filesConfig[$i]} $gitRaw$i
		source ${files[$i]}
		echo "${GREEN}The file $i a été mis à jour.${RESET}"
	done
}

####################################################################
#                                                                  #
#            GIT CONFIGURATION                                     #
#                                                                  #
####################################################################
addGITConfiguration() {
	echo "Démarrage de la configuration de GIT..."

	if [ -f $HOME/.gitconfig ];
	then
		git config --global user.name "Guillaume Astier"
		git config --global user.email "astier.gui@gmail.com"
	else
		echo "${RED}The .gitconfig file does not exist.${RESET}"
	fi

	echo "${GREEN}Configuration de GIT effectué.${RESET}"
}

####################################################################
#                                                                  #
#            VIM CONFIGURATION                                     #
#                                                                  #
####################################################################
addVIMConfiguration() {
	colorDir="$HOME/.vim/colors"

	echo "Démarrage de la configuration de VIM..."

	# Create folder if not exist
	create_directory $colorDir

	# Download theme
	curl -so $colorDir/desertEx.vim $gitRaw/colors/desertEx.vim
	echo "${GREEN}Configuration de l'éditeur effectué.${RESET}"
}

####################################################################
#                                                                  #
#            DOCKER CONFIGURATION                                  #
#                                                                  #
####################################################################
addDockerConfiguration() {
	dockerDir="$HOME/Docker"

	# Configuration files
	declare -A FilesDocker
	FilesDocker=( ['node']="$dockerDir/node" \
	)

	echo "Démarrage de la configuration de Docker..."

	# Download configuration
	for i in "${!FilesDocker[@]}"
	do
		create_directory ${FilesDocker[$i]}

		# Get file
		curl -so ${FilesDocker[$i]}/DockerFile $gitRaw/docker/$i/DockerFile
		echo "${GREEN}The DockerFile for '$i' a été installé.${RESET}"
	done

	echo "${GREEN}Configuration de docker effectué.${RESET}"
}

####################################################################
#                                                                  #
#            LAUNCH                                                #
#                                                                  #
####################################################################
init
echo "Enjoy :)"
