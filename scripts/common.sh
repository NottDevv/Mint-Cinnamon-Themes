#!/usr/bin/env bash

set -Eeuo pipefail

RESET='\033[0m'
BOLD='\033[1m'

RED='\033[38;5;203m'
GREEN='\033[38;5;114m'
YELLOW='\033[38;5;221m'
BLUE='\033[38;5;75m'
CYAN='\033[38;5;87m'
GRAY='\033[38;5;245m'
WHITE='\033[38;5;255m'

info() {
    echo -e "  ${BLUE}●${RESET} $1"
}

success() {
    echo -e "  ${GREEN}✔${RESET} $1"
}

warning() {
    echo -e "  ${YELLOW}⚠${RESET} $1"
}

error_msg() {
    echo -e "  ${RED}✖${RESET} $1"
}

install_dependencies() {

    info "Installing required dependencies..."

    sudo apt update

    sudo apt install -y \
        git \
        curl \
        wget \
        sassc \
        bc \
        gtk2-engines-murrine \
        gnome-themes-extra \
        libglib2.0-dev-bin \
        libxml2-utils

    success "Dependencies installed."
}

clone_or_update() {

    local repo="$1"
    local destination="$2"

    if [[ -d "$destination/.git" ]]; then

        info "Updating $(basename "$destination")..."

        git -C "$destination" pull --ff-only || \
            warning "Update failed. Using existing copy."

    else

        info "Downloading $(basename "$destination")..."

        git clone --depth=1 "$repo" "$destination"

    fi
}

run_installer() {

    local directory="$1"
    shift

    if [[ ! -f "$directory/install.sh" ]]; then
        error_msg "Installer not found: $directory/install.sh"
        return 1
    fi

    chmod +x "$directory/install.sh"

    (
        cd "$directory"
        ./install.sh "$@"
    )
}
