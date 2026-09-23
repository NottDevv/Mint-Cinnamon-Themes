#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BASE="$HOME/.local/share/mint-cinnamon-themes/sources"

CHROMEOS_GTK="https://github.com/vinceliuice/ChromeOS-theme.git"
OZONE_ICONS="https://github.com/sakuhanaX3/Ozone-icons.git"

mkdir -p "$BASE"

clear

echo
echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║                 CHROMEOS THEME                       ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${RESET}"
echo

echo -e "${GRAY}ChromeOS / Material-inspired desktop appearance.${RESET}"
echo

install_dependencies

clone_or_update \
    "$CHROMEOS_GTK" \
    "$BASE/ChromeOS-theme"

clone_or_update \
    "$OZONE_ICONS" \
    "$BASE/Ozone-icons"

echo
info "Installing ChromeOS GTK theme..."

run_installer \
    "$BASE/ChromeOS-theme"

echo
info "Installing Ozone icons..."

ICON_DEST="$HOME/.local/share/icons"
mkdir -p "$ICON_DEST"

if [[ -d "$BASE/Ozone-icons" ]]; then

    find "$BASE/Ozone-icons" \
        -maxdepth 2 \
        -type d \
        \( -name "Vector*" -o -name "Ozone*" \) \
        -exec cp -a {} "$ICON_DEST/" \; \
        2>/dev/null || true

fi

echo
success "ChromeOS theme installation finished."

echo
echo -e "${WHITE}${BOLD}Next step:${RESET}"
echo "  Open System Settings → Themes"
echo "  and select the ChromeOS theme."
echo

read -rp "Press Enter to return..."
