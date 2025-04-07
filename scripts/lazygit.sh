#!/bin/bash

install() {
    local VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/lazygit_${VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    rm -rf lazygit.tar.gz lazygit

    local COMMAND=$(lazygit --version)
    env GREP_COLORS='mt=01;32' grep --color=always -E '.*' <<< "Lazygit installed successfully"
    echo "Version: $COMMAND"
}

install
