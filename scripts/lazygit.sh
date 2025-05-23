#!/bin/bash

source ./utils.sh

install() {
    local REPOSITORY_NAME="jesseduffield/lazygit"
    local VERSION=$(get_latest_tag_by_repo "$REPOSITORY_NAME")
    local URL=''
    printf -v URL "https://github.com/%s/releases/download/v%s/lazygit_%s_%s_%s.tar.gz" "${REPOSITORY_NAME}" "${VERSION}" "${VERSION}" "$(uname -s)" "$(uname -m)"

    echo "... downloading from $URL"
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
