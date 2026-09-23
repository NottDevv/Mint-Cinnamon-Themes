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
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}║              WINDOWS 11 THEME                        ║${RESET}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"
echo -e "${GRAY}Windows 11 inspired GTK theme and icon pack.${RESET}\n"

# انتخاب رنگ تم توسط کاربر
echo -e "  ${WHITE}${BOLD}Select Theme Variant:${RESET}"
echo -e "  [${CYAN}1${RESET}] Light Only"
echo -e "  [${CYAN}2${RESET}] Dark Only"
echo -e "  [${CYAN}3${RESET}] Both (Light & Dark)\n"
read -rp "  Selection [3]: " color_choice

COLOR_FLAGS=("-c" "light" "-c" "dark") # پیش‌فرض نصب هردو
case "$color_choice" in
    1) COLOR_FLAGS=("-c" "light") ;;
    2) COLOR_FLAGS=("-c" "dark") ;;
    3|"") COLOR_FLAGS=("-c" "light" "-c" "dark") ;;
    *) warning "Invalid choice, defaulting to Both."; sleep 1 ;;
esac

echo
install_dependencies

# دانلود یا آپدیت سورس‌ها
clone_or_update "$WIN11_GTK" "$BASE/Win11-gtk-theme"
clone_or_update "$WIN11_ICONS" "$BASE/Win11-icon-theme"

# نصب GTK
echo
info "Installing Windows 11 GTK theme..."
if run_installer "$BASE/Win11-gtk-theme" -t blue "${COLOR_FLAGS[@]}" -s standard; then
    success "Windows 11 GTK Theme installed."
else
    error_msg "Failed to install Windows 11 GTK theme."
fi

# نصب Icons
echo
info "Installing Windows 11 icons..."
if run_installer "$BASE/Win11-icon-theme" -t blue -b; then
    success "Windows 11 Icon Theme installed."
else
    error_msg "Failed to install Windows 11 icon theme."
fi

echo
success "Windows 11 theme installation process finished."
echo -e "\n  ${WHITE}${BOLD}Next step:${RESET}"
echo -e "  Open System Settings → Themes and select the Win11 theme and icons."

pause_screen
