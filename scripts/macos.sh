#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BASE="$HOME/.local/share/mint-cinnamon-themes/sources"
MACOS_GTK="https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
MACOS_ICONS="https://github.com/vinceliuice/WhiteSur-icon-theme.git"

mkdir -p "$BASE"

clear
echo
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}║                  macOS THEME                         ║${RESET}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"
echo -e "${GRAY}WhiteSur GTK and WhiteSur icon theme.${RESET}\n"

# ۱. تفکیک بخش‌های مورد نیاز
echo -e "  ${WHITE}${BOLD}What would you like to install?${RESET}"
echo -e "  [${CYAN}1${RESET}] Both Theme & Icons"
echo -e "  [${CYAN}2${RESET}] Theme Only (GTK)"
echo -e "  [${CYAN}3${RESET}] Icons Only\n"
read -rp "  Selection [1]: " COMPONENT_CHOICE
COMPONENT_CHOICE="${COMPONENT_CHOICE:-1}"

# ۲. حالت تاریک/روشن (فقط در صورت نصب تم GTK)
COLOR_FLAGS=("-c" "Light" "-c" "Dark")
if [[ "$COMPONENT_CHOICE" == "1" || "$COMPONENT_CHOICE" == "2" ]]; then
    echo
    echo -e "  ${WHITE}${BOLD}Select Theme Variant:${RESET}"
    echo -e "  [${CYAN}1${RESET}] Light Only"
    echo -e "  [${CYAN}2${RESET}] Dark Only"
    echo -e "  [${CYAN}3${RESET}] Both (Light & Dark)\n"
    read -rp "  Selection [3]: " color_choice

    case "$color_choice" in
        1) COLOR_FLAGS=("-c" "Light") ;;
        2) COLOR_FLAGS=("-c" "Dark") ;;
        3|"") COLOR_FLAGS=("-c" "Light" "-c" "Dark") ;;
        *) warning "Invalid choice, defaulting to Both."; sleep 1 ;;
    esac
fi

echo
install_dependencies

# ۳. اجرای عملیات بر اساس انتخاب
case "$COMPONENT_CHOICE" in
    1)
        clone_or_update "$MACOS_GTK" "$BASE/WhiteSur-gtk-theme"
        clone_or_update "$MACOS_ICONS" "$BASE/WhiteSur-icon-theme"
        
        info "Installing macOS GTK theme..."
        run_installer "$BASE/WhiteSur-gtk-theme" "${COLOR_FLAGS[@]}" -N glass -s 220 && success "GTK Theme installed."
        
        info "Installing macOS icons..."
        run_installer "$BASE/WhiteSur-icon-theme" -a && success "Icon Theme installed."
        ;;
    2)
        clone_or_update "$MACOS_GTK" "$BASE/WhiteSur-gtk-theme"
        
        info "Installing macOS GTK theme..."
        run_installer "$BASE/WhiteSur-gtk-theme" "${COLOR_FLAGS[@]}" -N glass -s 220 && success "GTK Theme installed."
        ;;
    3)
        clone_or_update "$MACOS_ICONS" "$BASE/WhiteSur-icon-theme"
        
        info "Installing macOS icons..."
        run_installer "$BASE/WhiteSur-icon-theme" -a && success "Icon Theme installed."
        ;;
    *)
        error_msg "Invalid choice."
        pause_screen
        exit 1
        ;;
esac

echo
success "macOS theme installation completed!"
echo -e "\n  ${WHITE}${BOLD}Next step:${RESET}"
echo -e "  Open System Settings → Themes and select WhiteSur theme or icons."

pause_screen
