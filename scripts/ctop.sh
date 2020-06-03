#!/bin/bash                                                                     
                                                                  
install() {
    local NAME='ctop'
    local REPO='https://github.com/bcicen/ctop'

    local VERSION=$(git ls-remote $REPO | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]*\.[0-9]+$" | sort --version-sort | tail -n 1)
    local URL=''
    printf -v URL "https://github.com/bcicen/ctop/releases/download/v%s/ctop-%s-linux-amd64" "${VERSION}" "${VERSION}"

    echo "Downloading: $URL"
    sudo curl -L "$URL" -o /usr/local/bin/$NAME
    sudo chmod +x /usr/local/bin/$NAME
}

install
