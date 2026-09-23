#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BASE="$HOME/.local/share/mint-cinnamon-themes/sources"
CHROME_GTK="https://github.com/vinceliuice/ChromeOS-theme.git"
CHROME_ICONS="https://github.com/vinceliuice/ChromeOS-icon-theme.git"

mkdir -p "$BASE"

clear
echo
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}║               CHROMEOS THEME                         ║${RESET}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"
echo -e "${GRAY}ChromeOS style GTK theme and icon pack.${RESET}\n"

# ۱. تفکیک بخش‌های مورد نیاز
echo -e "  ${WHITE}${BOLD}What would you like to install?${RESET}"
echo -e "  [${CYAN}1${RESET}] Both Theme & Icons"
echo -e "  [${CYAN}2${RESET}] Theme Only (GTK)"
echo -e "  [${CYAN}3${RESET}] Icons Only\n"
read -rp "  Selection [1]: " COMPONENT_CHOICE
COMPONENT_CHOICE="${COMPONENT_CHOICE:-1}"

# ۲. حالت تاریک/روشن (فقط در صورت نصب تم GTK)
COLOR_FLAGS=("-c" "light" "-c" "dark")
if [[ "$COMPONENT_CHOICE" == "1" || "$COMPONENT_CHOICE" == "2" ]]; then
    echo
    echo -e "  ${WHITE}${BOLD}Select Theme Variant:${RESET}"
    echo -e "  [${CYAN}1${RESET}] Light Only"
    echo -e "  [${CYAN}2${RESET}] Dark Only"
    echo -e "  [${CYAN}3${RESET}] Both (Light & Dark)\n"
    read -rp "  Selection [3]: " color_choice

    case "$color_choice" in
        1) COLOR_FLAGS=("-c" "light") ;;
        2) COLOR_FLAGS=("-c" "dark") ;;
        3|"") COLOR_FLAGS=("-c" "light" "-c" "dark") ;;
        *) warning "Invalid choice, defaulting to Both."; sleep 1 ;;
    esac
fi

echo
install_dependencies

# ۳. اجرای عملیات بر اساس انتخاب
case "$COMPONENT_CHOICE" in
    1)
        clone_or_update "$CHROME_GTK" "$BASE/ChromeOS-theme"
        clone_or_update "$CHROME_ICONS" "$BASE/ChromeOS-icon-theme"
        
        info "Installing ChromeOS GTK theme..."
        run_installer "$BASE/ChromeOS-theme" "${COLOR_FLAGS[@]}" && success "GTK Theme installed."
        
        info "Installing ChromeOS icons..."
        run_installer "$BASE/ChromeOS-icon-theme" -a && success "Icon Theme installed."
        ;;
    2)
        clone_or_update "$CHROME_GTK" "$BASE/ChromeOS-theme"
        
        info "Installing ChromeOS GTK theme..."
        run_installer "$BASE/ChromeOS-theme" "${COLOR_FLAGS[@]}" && success "GTK Theme installed."
        ;;
    3)
        clone_or_update "$CHROME_ICONS" "$BASE/ChromeOS-icon-theme"
        
        info "Installing ChromeOS icons..."
        run_installer "$BASE/ChromeOS-icon-theme" -a && success "Icon Theme installed."
        ;;
    *)
        error_msg "Invalid choice."
        pause_screen
        exit 1
        ;;
esac

echo
success "ChromeOS theme installation completed!"
echo -e "\n  ${WHITE}${BOLD}Next step:${RESET}"
echo -e "  Open System Settings → Themes and select ChromeOS theme or icons."

pause_screen
