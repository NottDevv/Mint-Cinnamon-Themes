#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BASE="$HOME/.local/share/mint-cinnamon-themes/sources"

WIN11_GTK="https://github.com/yeyushengfan258/Win11-gtk-theme.git"
WIN11_ICONS="https://github.com/yeyushengfan258/Win11-icon-theme.git"

mkdir -p "$BASE"

clear

echo
echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║              WINDOWS 11 THEME                        ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${RESET}"
echo

echo -e "${GRAY}Windows 11 inspired GTK theme and icon pack.${RESET}"
echo

install_dependencies

clone_or_update \
    "$WIN11_GTK" \
    "$BASE/Win11-gtk-theme"

clone_or_update \
    "$WIN11_ICONS" \
    "$BASE/Win11-icon-theme"

echo
info "Installing Windows 11 GTK theme..."

run_installer \
    "$BASE/Win11-gtk-theme" \
    -t blue \
    -c standard \
    -s standard

echo
info "Installing Windows 11 icons..."

run_installer \
    "$BASE/Win11-icon-theme" \
    -t blue \
    -b

echo
success "Windows 11 theme installed."

echo
echo -e "${WHITE}${BOLD}Next step:${RESET}"
echo "  Open System Settings → Themes"
echo "  and select the Win11 theme and icons."

echo
read -rp "Press Enter to return..."
