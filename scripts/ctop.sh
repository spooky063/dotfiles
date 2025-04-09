#!/bin/bash

source ./utils.sh

install() {
    local REPOSITORY_NAME="bcicen/ctop"
    local VERSION=$(get_latest_tag_by_repo "$REPOSITORY_NAME")
    local OS=$(lowercase $(uname -s))
    local URL=''
    printf -v URL "https://github.com/%s/releases/download/v%s/ctop-%s-%s-%s" "${REPOSITORY_NAME}" "${VERSION}" "${VERSION}" "${OS}" "$(arch)"

    echo "... downloading from $URL"
    sudo curl -sLo /usr/local/bin/ctop "$URL"

    if [ ! -f /usr/local/bin/ctop ]; then
        env GREP_COLORS='mt=01;31' grep --color=always -E '.*' <<< "Error while downloading file at: $URL"
        exit 1
    fi

    sudo chmod +x /usr/local/bin/ctop

    local COMMAND=$(ctop -v)
    env GREP_COLORS='mt=01;32' grep --color=always -E '.*' <<< "ctop installed successfully"
    echo "Version: $COMMAND"
}

install
