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
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}║                 CHROMEOS THEME                       ║${RESET}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"
echo -e "${GRAY}ChromeOS / Material-inspired desktop appearance.${RESET}\n"

echo -e "  ${WHITE}${BOLD}Select Theme Variant:${RESET}"
echo -e "  [${CYAN}1${RESET}] Light Only"
echo -e "  [${CYAN}2${RESET}] Dark Only"
echo -e "  [${CYAN}3${RESET}] Both (Light & Dark)\n"
read -rp "  Selection [3]: " color_choice

COLOR_FLAGS=("-c" "light" "-c" "dark")
case "$color_choice" in
    1) COLOR_FLAGS=("-c" "light") ;;
    2) COLOR_FLAGS=("-c" "dark") ;;
    3|"") COLOR_FLAGS=("-c" "light" "-c" "dark") ;;
    *) warning "Invalid choice, defaulting to Both."; sleep 1 ;;
esac

echo
install_dependencies

clone_or_update "$CHROMEOS_GTK" "$BASE/ChromeOS-theme"
clone_or_update "$OZONE_ICONS" "$BASE/Ozone-icons"

# نصب GTK
echo
info "Installing ChromeOS GTK theme..."
if run_installer "$BASE/ChromeOS-theme" "${COLOR_FLAGS[@]}"; then
    success "ChromeOS GTK Theme installed."
else
    error_msg "Failed to install ChromeOS GTK theme."
fi

# نصب Icons (کپی دستی چون پروژه فایل install.sh ندارد)
echo
info "Installing Ozone icons..."
ICON_DEST="$HOME/.local/share/icons"
mkdir -p "$ICON_DEST"

if [[ -d "$BASE/Ozone-icons" ]]; then
    # بررسی خروجی دستور find و کپی
    if find "$BASE/Ozone-icons" -maxdepth 2 -type d \( -name "Vector*" -o -name "Ozone*" \) -exec cp -a {} "$ICON_DEST/" \; 2>/dev/null; then
        success "Ozone Icon Theme installed."
    else
        error_msg "Failed to copy Ozone icons."
    fi
else
    error_msg "Ozone icons source not found."
fi

echo
success "ChromeOS theme installation process finished."
echo -e "\n  ${WHITE}${BOLD}Next step:${RESET}"
echo -e "  Open System Settings → Themes and select the ChromeOS theme."

pause_screen
