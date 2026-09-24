#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BASE="$HOME/.local/share/mint-cinnamon-themes/sources"
MACOS_GTK="https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
MACOS_ICONS="https://github.com/vinceliuice/WhiteSur-icon-theme.git"

mkdir -p "$BASE"

show_header() {
    clear
    echo
    echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}${BOLD}║                  macOS THEME                         ║${RESET}"
    echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"
    echo -e "${GRAY}WhiteSur GTK and WhiteSur icon theme.${RESET}\n"
}

STEP=1
COLOR_FLAGS=("-c" "Light" "-c" "Dark")
COMPONENT_CHOICE="1"

while true; do
    case "$STEP" in
        1)
            show_header
            echo -e "  ${WHITE}${BOLD}What would you like to install?${RESET}"
            echo -e "  [${CYAN}1${RESET}] Both Theme & Icons"
            echo -e "  [${CYAN}2${RESET}] Theme Only (GTK)"
            echo -e "  [${CYAN}3${RESET}] Icons Only"
            echo -e "  [${CYAN}0${RESET}] ← Back\n"
            read -rp "  Selection [1]: " COMPONENT_CHOICE
            COMPONENT_CHOICE="${COMPONENT_CHOICE:-1}"

            case "$COMPONENT_CHOICE" in
                0) exit 0 ;;
                1|2) STEP=2 ;;
                3) STEP=3 ;;
                *) warning "Invalid choice."; sleep 1 ;;
            esac
            ;;
        2)
            show_header
            echo -e "  ${WHITE}${BOLD}Select Theme Variant:${RESET}"
            echo -e "  [${CYAN}1${RESET}] Light Only"
            echo -e "  [${CYAN}2${RESET}] Dark Only"
            echo -e "  [${CYAN}3${RESET}] Both (Light & Dark)"
            echo -e "  [${CYAN}0${RESET}] ← Back\n"
            read -rp "  Selection [3]: " color_choice

            case "$color_choice" in
                0) STEP=1 ;;
                1) COLOR_FLAGS=("-c" "Light"); STEP=3 ;;
                2) COLOR_FLAGS=("-c" "Dark"); STEP=3 ;;
                3|"") COLOR_FLAGS=("-c" "Light" "-c" "Dark"); STEP=3 ;;
                *) warning "Invalid choice."; sleep 1 ;;
            esac
            ;;
        3)
            break
            ;;
    esac
done

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
esac

echo
success "macOS theme installation completed!"
echo -e "\n  ${WHITE}${BOLD}Next step:${RESET}"
echo -e "  Open System Settings → Themes and select WhiteSur theme or icons."

pause_screen
