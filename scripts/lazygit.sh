#!/bin/bash

get_latest_tag_by_repo() {
    curl -s "https://api.github.com/repos/$1/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*'
}

install() {
    local REPOSITORY_NAME="jesseduffield/lazygit"
    local VERSION=$(get_latest_tag_by_repo "$REPOSITORY_NAME")
    local URL=''
    printf -v URL "https://github.com/%s/releases/download/v%s/lazygit_%s_Linux_x86_64.tar.gz" "${REPOSITORY_NAME}" "${VERSION}" "${VERSION}"

    sudo curl -sLo lazygit.tar.gz "$URL"

    if [ ! -f /usr/local/bin/ctop ]; then
        env GREP_COLORS='mt=01;31' grep --color=always -E '.*' <<< "Error while downloading file at: $URL"
        exit 1
    fi

    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    rm -rf lazygit.tar.gz lazygit

    local COMMAND=$(lazygit --version)
    env GREP_COLORS='mt=01;32' grep --color=always -E '.*' <<< "lazygit installed successfully"
    echo "Version: $COMMAND"
}

install
