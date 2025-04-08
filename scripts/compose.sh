#!/bin/bash

get_latest_tag_by_repo() {
    curl -s "https://api.github.com/repos/$1/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*'
}

lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

install() {
    local REPOSITORY_NAME="docker/compose"
    local VERSION=$(get_latest_tag_by_repo "$REPOSITORY_NAME")
    local OS=$(lowercase $(uname -s))
    local URL=''
    printf -v URL "https://github.com/%s/releases/download/v%s/docker-compose-%s-%s" "${REPOSITORY_NAME}" "${VERSION}" "${OS}" "$(uname -m)"

    echo "... downloading from $URL"
    sudo curl -sLo /usr/local/bin/docker-compose "$URL"

    if [ ! -f /usr/local/bin/docker-compose ]; then
        env GREP_COLORS='mt=01;31' grep --color=always -E '.*' <<< "Error while downloading file at: $URL"
        exit 1
    fi

    sudo chmod +x /usr/local/bin/docker-compose

    local COMMAND=$(docker-compose version)
    env GREP_COLORS='mt=01;32' grep --color=always -E '.*' <<< "docker-compose installed successfully"
    echo "Version: $COMMAND"
}

install
