#!/bin/bash

source ./utils.sh

install() {
    local REPOSITORY_NAME="vercel/geist-font"
    local VERSION=$(get_latest_tag_by_repo "$REPOSITORY_NAME")
    local URL=''
    printf -v URL "https://github.com/%s/releases/download/%s/GeistMono-%s.zip" "${REPOSITORY_NAME}" "${VERSION}" "${VERSION}"

    echo "... downloading from $URL"
    sudo curl -sLo /tmp/geist.zip "$URL"

    if [ ! -f /tmp/geist.zip ]; then
        env GREP_COLORS='mt=01;31' grep --color=always -E '.*' <<< "Error while downloading file at: $URL"
        exit 1
    fi

    unzip -qo /tmp/geist.zip -d /tmp

    sudo mkdir -p $HOME/.local/share/fonts
    find /tmp/GeistMono-"${VERSION}" -name "*.ttf" -not -name "*[[]*" -not -path "*variable*" -print0 | xargs -0 -I {} cp {} "$HOME/.local/share/fonts/"

    sudo rm -rf /tmp/geist.zip
    sudo rm -rf /tmp/GeistMono-${VERSION}

    env GREP_COLORS='mt=01;32' grep --color=always -E '.*' <<< "GeistMono font installed successfully"
}

install