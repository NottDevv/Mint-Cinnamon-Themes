#!/usr/bin/env bash

set -Eeuo pipefail

VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

RESET='\033[0m'
BOLD='\033[1m'

RED='\033[38;5;203m'
GREEN='\033[38;5;114m'
YELLOW='\033[38;5;221m'
BLUE='\033[38;5;75m'
CYAN='\033[38;5;87m'
MAGENTA='\033[38;5;213m'
WHITE='\033[38;5;255m'
GRAY='\033[38;5;245m'

# ------------------------------------------------------------
# UI
# ------------------------------------------------------------

clear_screen() {
    clear 2>/dev/null || true
}

header() {
    clear_screen

    echo
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║              MINT CINNAMON THEMES                          ║"
    echo "║                                                            ║"
    echo "║       Windows 11  •  macOS  •  ChromeOS                   ║"
    echo "║                                                            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"

    echo -e "              ${GRAY}Theme Manager v${VERSION}${RESET}"
    echo
}

pause_screen() {
    echo
    read -rp "  Press Enter to continue..."
}

info() {
    echo -e "  ${BLUE}●${RESET} $1"
}

success() {
    echo -e "  ${GREEN}✔${RESET} $1"
}

warning() {
    echo -e "  ${YELLOW}⚠${RESET} $1"
}

error_msg() {
    echo -e "  ${RED}✖${RESET} $1"
}

# ------------------------------------------------------------
# Validation
# ------------------------------------------------------------

check_os() {

    if [[ ! -f /etc/os-release ]]; then
        error_msg "Cannot detect operating system."
        exit 1
    fi

    source /etc/os-release

    if [[ "${ID:-}" != "linuxmint" ]]; then
        warning "This project is designed for Linux Mint."
        warning "Detected: ${PRETTY_NAME:-Unknown}"
        echo

        read -rp "Continue anyway? [y/N]: " answer

        [[ "$answer" =~ ^[Yy]$ ]] || exit 0
    fi
}

check_cinnamon() {

    if ! command -v cinnamon >/dev/null 2>&1; then
        warning "Cinnamon desktop was not detected."
        warning "This project is designed for Cinnamon."
        echo

        read -rp "Continue anyway? [y/N]: " answer

        [[ "$answer" =~ ^[Yy]$ ]] || exit 0
    fi
}

# ------------------------------------------------------------
# Main menus
# ------------------------------------------------------------

install_menu() {

    while true; do

        header

        echo -e "${WHITE}${BOLD}  INSTALL THEMES${RESET}"
        echo -e "  ${GRAY}Choose a desktop appearance to install.${RESET}"
        echo

        echo -e "  ${CYAN}1${RESET}  🪟  Windows 11"
        echo -e "       ${GRAY}GTK theme + icons + Cinnamon integration${RESET}"
        echo

        echo -e "  ${CYAN}2${RESET}  🍎  macOS"
        echo -e "       ${GRAY}WhiteSur GTK + WhiteSur Icons${RESET}"
        echo

        echo -e "  ${CYAN}3${RESET}  💻  ChromeOS"
        echo -e "       ${GRAY}ChromeOS GTK + ChromeOS-style icons${RESET}"
        echo

        echo -e "  ${CYAN}4${RESET}  🚀  Install ALL"
        echo -e "       ${GRAY}Install all three theme families${RESET}"
        echo

        echo -e "  ${CYAN}0${RESET}  ←  Back"
        echo

        read -rp "  Select an option: " choice

        case "$choice" in

            1)
                bash "$SCRIPT_DIR/scripts/windows11.sh"
                ;;

            2)
                bash "$SCRIPT_DIR/scripts/macos.sh"
                ;;

            3)
                bash "$SCRIPT_DIR/scripts/chromeos.sh"
                ;;

            4)
                bash "$SCRIPT_DIR/scripts/windows11.sh"
                bash "$SCRIPT_DIR/scripts/macos.sh"
                bash "$SCRIPT_DIR/scripts/chromeos.sh"
                ;;

            0)
                return
                ;;

            *)
                warning "Invalid option."
                sleep 1
                ;;

        esac

    done
}

uninstall_menu() {

    while true; do

        header

        echo -e "${RED}${BOLD}  UNINSTALL THEMES${RESET}"
        echo -e "  ${GRAY}Remove only the selected theme family.${RESET}"
        echo

        echo -e "  ${CYAN}1${RESET}  🪟  Windows 11"
        echo

        echo -e "  ${CYAN}2${RESET}  🍎  macOS / WhiteSur"
        echo

        echo -e "  ${CYAN}3${RESET}  💻  ChromeOS"
        echo

        echo -e "  ${CYAN}4${RESET}  🗑️  Remove ALL managed themes"
        echo

        echo -e "  ${CYAN}0${RESET}  ←  Back"
        echo

        read -rp "  Select an option: " choice

        case "$choice" in

            1)
                bash "$SCRIPT_DIR/scripts/uninstall.sh" windows11
                ;;

            2)
                bash "$SCRIPT_DIR/scripts/uninstall.sh" macos
                ;;

            3)
                bash "$SCRIPT_DIR/scripts/uninstall.sh" chromeos
                ;;

            4)
                bash "$SCRIPT_DIR/scripts/uninstall.sh" all
                ;;

            0)
                return
                ;;

            *)
                warning "Invalid option."
                sleep 1
                ;;

        esac

    done
}

# ------------------------------------------------------------
# Main
# ------------------------------------------------------------

check_os
check_cinnamon

while true; do

    header

    echo -e "  ${WHITE}${BOLD}A modern theme manager for Linux Mint Cinnamon.${RESET}"
    echo -e "  ${GRAY}Install and switch between Windows 11, macOS and ChromeOS styles.${RESET}"
    echo

    echo -e "${GRAY}  ────────────────────────────────────────────────────────${RESET}"
    echo

    echo -e "  ${GREEN}1${RESET}  🎨  Install Themes"
    echo -e "       ${GRAY}Windows 11 / macOS / ChromeOS${RESET}"
    echo

    echo -e "  ${RED}2${RESET}  🗑️  Uninstall Themes"
    echo -e "       ${GRAY}Remove selected theme families${RESET}"
    echo

    echo -e "  ${YELLOW}3${RESET}  🚪  Exit"
    echo

    echo -e "${GRAY}  ────────────────────────────────────────────────────────${RESET}"
    echo

    read -rp "  Select an option: " choice

    case "$choice" in

        1)
            install_menu
            ;;

        2)
            uninstall_menu
            ;;

        3)
            clear_screen
            echo
            echo -e "  ${GREEN}${BOLD}Thank you for using Mint Cinnamon Themes!${RESET}"
            echo
            exit 0
            ;;

        *)
            warning "Please select 1, 2 or 3."
            sleep 1
            ;;

    esac

done
