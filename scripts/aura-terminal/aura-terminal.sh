#!/bin/bash

dconfdir=/org/gnome/terminal/legacy/profiles:

download_dconf() {
    local URL="https://raw.githubusercontent.com/daltonmenezes/aura-theme/main/packages/gnome-terminal/aura-theme.dconf"
    curl -sLo ./aura-theme.dconf "$URL"

    if [ ! -f ./aura-theme.dconf ]; then
        env GREP_COLORS='mt=01;31' grep --color=always -E '.*' <<< "Error while downloading file at: $URL"
        exit 1
    fi
}

install() {
    download_dconf
    local FILE="./aura-theme.dconf"

    local NEW_PROFILE_UUID=$(uuidgen)
    local NEW_PROFILE_NAME="Aura"

    local PROFILE_LIST=$(dconf read "$dconfdir"/list | tr -d "[]' " | tr , '\n')
    local UPDATED_LIST=$(echo -e "$PROFILE_LIST\n$NEW_PROFILE_UUID" | awk '!seen[$0]++' | tr '\n' ',' | sed 's/,$//')
    local UPDATED_LIST_FORMATTED="[$(echo "$UPDATED_LIST" | sed "s/[^,]*/'&'/g")]"

    dconf write "$dconfdir"/list "$UPDATED_LIST_FORMATTED"
    dconf write "$dconfdir/:$NEW_PROFILE_UUID"/visible-name "'$NEW_PROFILE_NAME'"

    dconf load "$dconfdir/:$NEW_PROFILE_UUID"/ < "$FILE"

    dconf write "$dconfdir"/default "'$NEW_PROFILE_UUID'"

    rm -rf $FILE

    env GREP_COLORS='mt=01;32' grep --color=always -E '.*' <<< "New aura-terminal profile installed successfully"
    echo "Please reload your terminal for the changes to take effect."
}

install