#!/bin/bash                                                                     
                                                                  
install() {
    local NAME='docker-compose'
    local REPO='https://github.com/docker/compose'

    local VERSION=$(git ls-remote $REPO | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]*\.[0-9]+$" | sort --version-sort | tail -n 1)
    local URL=''
    printf -v URL "https://github.com/docker/compose/releases/download/%s/docker-compose-%s-%s" "${VERSION}" "$(uname -s)" "$(uname -m)"

    echo "Downloading: $URL"
    sudo curl -L "$URL" -o /usr/local/bin/$NAME
    sudo chmod +x /usr/local/bin/$NAME
}

install
