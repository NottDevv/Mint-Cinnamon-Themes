#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BASE="$HOME/.local/share/mint-cinnamon-themes/sources"

WHITESUR_GTK="https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
WHITESUR_ICONS="https://github.com/vinceliuice/WhiteSur-icon-theme.git"

mkdir -p "$BASE"

clear

echo
echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║                 macOS THEME                          ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${RESET}"
echo

echo -e "${GRAY}WhiteSur GTK and WhiteSur icon theme.${RESET}"
echo

install_dependencies

clone_or_update \
    "$WHITESUR_GTK" \
    "$BASE/WhiteSur-gtk-theme"

clone_or_update \
    "$WHITESUR_ICONS" \
    "$BASE/WhiteSur-icon-theme"

echo
info "Installing WhiteSur GTK..."

run_installer \
    "$BASE/WhiteSur-gtk-theme" \
    -c light \
    -c dark

echo
info "Installing WhiteSur icons..."

run_installer \
    "$BASE/WhiteSur-icon-theme" \
    -t blue \
    -b

echo
success "macOS / WhiteSur theme installed."

echo
echo -e "${WHITE}${BOLD}Next step:${RESET}"
echo "  Open System Settings → Themes"
echo "  and select WhiteSur."

echo
read -rp "Press Enter to return..."
