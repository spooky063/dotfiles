#!/bin/bash

lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

get_latest_tag_by_repo() {
    curl -s "https://api.github.com/repos/$1/releases/latest" | grep -Po '"tag_name": *"\K[^"]+' | sed 's/^v//'
}

arch() {
    local arch="$(uname -m)"

    case "$arch" in
        x86_64) arch="amd64" ;;
        aarch64 | arm64) arch="arm64" ;;
        i386 | i686) arch="386" ;;
        *) arch="unknown" ;;
    esac

    echo "${arch}"
}