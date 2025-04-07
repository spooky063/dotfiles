#!/bin/bash

install() {
    local NAME='ctop'
    local REPO='https://github.com/bcicen/ctop'

    local VERSION=$(curl -s "https://api.github.com/repos/bcicen/ctop/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    local URL=''
    printf -v URL "https://github.com/bcicen/ctop/releases/download/v%s/ctop-%s-linux-amd64" "${VERSION}" "${VERSION}"

    echo "Downloading: $URL"
    sudo curl -L "$URL" -o /usr/local/bin/$NAME
    sudo chmod +x /usr/local/bin/$NAME
}

install
