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
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}║                 macOS THEME                          ║${RESET}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"
echo -e "${GRAY}WhiteSur GTK and WhiteSur icon theme.${RESET}\n"

# انتخاب رنگ تم توسط کاربر
echo -e "  ${WHITE}${BOLD}Select Theme Variant:${RESET}"
echo -e "  [${CYAN}1${RESET}] Light Only"
echo -e "  [${CYAN}2${RESET}] Dark Only"
echo -e "  [${CYAN}3${RESET}] Both (Light & Dark)\n"
read -rp "  Selection [3]: " color_choice

COLOR_FLAGS=("-c" "light" "-c" "dark") # پیش‌فرض Both
case "$color_choice" in
    1) COLOR_FLAGS=("-c" "light") ;;
    2) COLOR_FLAGS=("-c" "dark") ;;
    3|"") COLOR_FLAGS=("-c" "light" "-c" "dark") ;;
    *) warning "Invalid choice, defaulting to Both."; sleep 1 ;;
esac

echo
install_dependencies

# دانلود یا آپدیت سورس‌ها
clone_or_update "$WHITESUR_GTK" "$BASE/WhiteSur-gtk-theme"
clone_or_update "$WHITESUR_ICONS" "$BASE/WhiteSur-icon-theme"

# نصب GTK
echo
info "Installing WhiteSur GTK..."
if run_installer "$BASE/WhiteSur-gtk-theme" "${COLOR_FLAGS[@]}"; then
    success "GTK Theme installed."
else
    error_msg "Failed to install GTK theme."
fi

# نصب Icons
echo
info "Installing WhiteSur icons..."
if run_installer "$BASE/WhiteSur-icon-theme" -t blue -b; then
    success "Icon Theme installed."
else
    error_msg "Failed to install icon theme."
fi

echo
success "macOS / WhiteSur theme installation process finished."
echo -e "\n  ${WHITE}${BOLD}Next step:${RESET}"
echo -e "  Open System Settings → Themes and select WhiteSur."

pause_screen
