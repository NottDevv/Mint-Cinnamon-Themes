#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

THEMES_DIR="$HOME/.themes"
ICONS_DIR="$HOME/.icons"
LOCAL_THEMES_DIR="$HOME/.local/share/themes"
LOCAL_ICONS_DIR="$HOME/.local/share/icons"

remove_theme() {
    local name="$1"
    local pattern="$2"
    local removed=0

    info "Removing $name themes..."

    # جستجو و حذف در پوشه‌های تم
    for dir in "$THEMES_DIR" "$LOCAL_THEMES_DIR"; do
        if [[ -d "$dir" ]]; then
            find "$dir" -maxdepth 1 -name "$pattern" -type d -exec rm -rf {} + && ((removed++)) || true
        fi
    done

    # جستجو و حذف در پوشه‌های آیکون
    for dir in "$ICONS_DIR" "$LOCAL_ICONS_DIR"; do
        if [[ -d "$dir" ]]; then
            find "$dir" -maxdepth 1 -name "$pattern" -type d -exec rm -rf {} + && ((removed++)) || true
        fi
    done

    if [[ $removed -gt 0 ]]; then
        success "$name components have been removed."
    else
        warning "No $name components found to remove."
    fi
}

TARGET="${1:-}"

clear
echo
echo -e "${RED}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${RED}${BOLD}║                 UNINSTALL THEMES                     ║${RESET}"
echo -e "${RED}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"

case "$TARGET" in
    "windows11")
        echo -e "  You are about to remove all ${WHITE}Windows 11${RESET} themes and icons."
        read -rp "  Are you sure? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            remove_theme "Windows 11" "Win11*"
        fi
        ;;
    "macos")
        echo -e "  You are about to remove all ${WHITE}macOS / WhiteSur${RESET} themes and icons."
        read -rp "  Are you sure? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            remove_theme "WhiteSur" "WhiteSur*"
        fi
        ;;
    "chromeos")
        echo -e "  You are about to remove all ${WHITE}ChromeOS & Ozone${RESET} themes and icons."
        read -rp "  Are you sure? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            remove_theme "ChromeOS" "ChromeOS*"
            remove_theme "Ozone Icons" "Ozone*"
            remove_theme "Ozone Vector" "Vector*"
        fi
        ;;
    "all")
        echo -e "  ${RED}${BOLD}WARNING!${RESET} You are about to remove ALL managed themes (Win11, macOS, ChromeOS)."
        read -rp "  Are you absolutely sure? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            remove_theme "Windows 11" "Win11*"
            remove_theme "WhiteSur" "WhiteSur*"
            remove_theme "ChromeOS" "ChromeOS*"
            remove_theme "Ozone Icons" "Ozone*"
            remove_theme "Ozone Vector" "Vector*"
            
            # پاک کردن سورس‌های دانلود شده
            info "Cleaning up downloaded source files..."
            rm -rf "$HOME/.local/share/mint-cinnamon-themes/sources"
            success "Source files cleared."
        fi
        ;;
    *)
        error_msg "No valid target specified for uninstallation."
        ;;
esac

pause_screen
