#!/usr/bin/env bash

# ۱. بررسی هوشمند اجرای آنلاین (curl | bash)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"

if [[ -z "$SCRIPT_DIR" || ! -f "$SCRIPT_DIR/scripts/common.sh" ]]; then
    echo -e " \033[1;34m●\033[0m Downloading installer files from GitHub..."
    TMP_DIR="$(mktemp -d)"

    # دانلود آرشیو پروژه بدون نیاز به داشتن git
    if curl -fsSL https://github.com/NottDevv/Mint-Cinnamon-Themes/archive/refs/heads/main.tar.gz | tar -xz -C "$TMP_DIR" --strip-components=1 2>/dev/null; then
        exec bash "$TMP_DIR/install.sh" "$@"
    else
        echo "Error: Failed to download repository from GitHub."
        rm -rf "$TMP_DIR"
        exit 1
    fi
fi

set -Eeuo pipefail

VERSION="1.1.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# بارگذاری توابع مشترک
source "$SCRIPT_DIR/scripts/common.sh"

# ------------------------------------------------------------
# UI و استایل‌های اصلی
# ------------------------------------------------------------

clear_screen() {
    clear 2>/dev/null || true
}

header() {
    clear_screen
    echo
    echo -e "${CYAN}${BOLD}"
    echo "╭──────────────────────────────────────────────────────╮"
    echo "│                                                      │"
    echo "│        MINT CINNAMON THEMES                          │"
    echo "│        Modern Theme Manager                          │"
    echo "│                                                      │"
    echo "│        Windows 11  •  macOS  •  ChromeOS             │"
    echo "│                                                      │"
    echo "╰──────────────────────────────────────────────────────╯"
    echo -e "${RESET}"
    echo -e "              ${GRAY}Version v${VERSION}${RESET}"
    echo
}

pause_screen() {
    echo
    read -rp "  Press Enter to continue..."
}

# ------------------------------------------------------------
# توابع سیستم و اعتبارسنجی
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
# وضعیت تم‌ها (Theme Status)
# ------------------------------------------------------------

theme_status() {
    header
    echo -e "${WHITE}${BOLD}  THEME STATUS${RESET}\n"

    # بررسی Windows 11
    if is_theme_installed "Win11*"; then
        echo -e "  Windows 11     ${GREEN}● Installed${RESET}"
    else
        echo -e "  Windows 11     ${GRAY}○ Not installed${RESET}"
    fi

    # بررسی macOS
    if is_theme_installed "WhiteSur*"; then
        echo -e "  macOS          ${GREEN}● Installed${RESET}"
    else
        echo -e "  macOS          ${GRAY}○ Not installed${RESET}"
    fi

    # بررسی ChromeOS
    if is_theme_installed "ChromeOS*"; then
        echo -e "  ChromeOS       ${GREEN}● Installed${RESET}"
    else
        echo -e "  ChromeOS       ${GRAY}○ Not installed${RESET}"
    fi

    echo

    # دریافت تم‌های فعال فعلی سیستم
    local current_gtk=$(gsettings get org.cinnamon.desktop.interface gtk-theme | tr -d "'")
    local current_icons=$(gsettings get org.cinnamon.desktop.interface icon-theme | tr -d "'")
    local current_cursor=$(gsettings get org.cinnamon.desktop.interface cursor-theme | tr -d "'")

    echo -e "  ${BLUE}Current Active Settings:${RESET}"
    echo -e "  GTK Theme:     ${CYAN}${current_gtk}${RESET}"
    echo -e "  Icons:         ${CYAN}${current_icons}${RESET}"
    echo -e "  Cursor:        ${CYAN}${current_cursor}${RESET}"

    pause_screen
}

# ------------------------------------------------------------
# منوهای اصلی
# ------------------------------------------------------------

install_menu() {
    while true; do
        header
        echo -e "${WHITE}${BOLD}  INSTALL THEMES${RESET}"
        echo -e "  ${GRAY}Choose a desktop appearance to install.${RESET}\n"

        echo -e "  [${CYAN}1${RESET}] 🪟 Windows 11"
        echo -e "  [${CYAN}2${RESET}] 🍎 macOS"
        echo -e "  [${CYAN}3${RESET}] 💻 ChromeOS"
        echo -e "  [${CYAN}4${RESET}] 🚀 Install ALL"
        echo -e "  [${CYAN}0${RESET}] ← Back\n"

        read -rp "  Select an option: " choice
        case "$choice" in
            1) bash "$SCRIPT_DIR/scripts/windows11.sh" ;;
            2) bash "$SCRIPT_DIR/scripts/macos.sh" ;;
            3) bash "$SCRIPT_DIR/scripts/chromeos.sh" ;;
            4) 
               bash "$SCRIPT_DIR/scripts/windows11.sh"
               bash "$SCRIPT_DIR/scripts/macos.sh"
               bash "$SCRIPT_DIR/scripts/chromeos.sh"
               # بعداً اینجا می‌توانیم Summary اضافه کنیم
               ;;
            0) return ;;
            *) warning "Invalid option."; sleep 1 ;;
        esac
    done
}

uninstall_menu() {
    while true; do
        header
        echo -e "${RED}${BOLD}  UNINSTALL THEMES${RESET}"
        echo -e "  ${GRAY}Remove only the selected theme family.${RESET}\n"

        echo -e "  [${CYAN}1${RESET}] 🪟 Windows 11"
        echo -e "  [${CYAN}2${RESET}] 🍎 macOS / WhiteSur"
        echo -e "  [${CYAN}3${RESET}] 💻 ChromeOS"
        echo -e "  [${CYAN}4${RESET}] 🗑️ Remove ALL managed themes"
        echo -e "  [${CYAN}0${RESET}] ← Back\n"

        read -rp "  Select an option: " choice
        case "$choice" in
            1) bash "$SCRIPT_DIR/scripts/uninstall.sh" windows11 ;;
            2) bash "$SCRIPT_DIR/scripts/uninstall.sh" macos ;;
            3) bash "$SCRIPT_DIR/scripts/uninstall.sh" chromeos ;;
            4) bash "$SCRIPT_DIR/scripts/uninstall.sh" all ;;
            0) return ;;
            *) warning "Invalid option."; sleep 1 ;;
        esac
    done
}

# ------------------------------------------------------------
# Main Loop
# ------------------------------------------------------------

check_os
check_cinnamon

while true; do
    header
    echo -e "  ┌─ Theme Manager ─────────────────────────────────┐"
    echo -e "  │                                                 │"
    echo -e "  │  [${GREEN}1${RESET}]  🎨 Install Themes                        │"
    echo -e "  │  [${RED}2${RESET}]  🗑️  Uninstall Themes                      │"
    echo -e "  │  [${BLUE}3${RESET}]  💾 Backup / Restore                      │"
    echo -e "  │  [${MAGENTA}4${RESET}]  📊 Theme Status                          │"
    echo -e "  │  [${YELLOW}5${RESET}]  🔄 Update Theme Sources                  │"
    echo -e "  │  [${CYAN}0${RESET}]  🚪 Exit                                  │"
    echo -e "  │                                                 │"
    echo -e "  └─────────────────────────────────────────────────┘\n"

    read -rp "  Select an option: " choice
    case "$choice" in
        1) install_menu ;;
        2) uninstall_menu ;;
        3) 
           # اجرای اسکریپت بکاپ که بعدا می‌سازیم
           if [ -f "$SCRIPT_DIR/scripts/backup_restore.sh" ]; then
               bash "$SCRIPT_DIR/scripts/backup_restore.sh"
           else
               warning "Feature coming soon!"
               pause_screen
           fi
           ;;
        4) theme_status ;;
        5) 
           # اجرای اسکریپت آپدیت که بعدا می‌سازیم
           warning "Feature coming soon!"
           pause_screen
           ;;
        0) clear_screen; echo -e "\n  ${GREEN}${BOLD}Thank you for using Mint Cinnamon Themes!${RESET}\n"; exit 0 ;;
        *) warning "Please select a valid option."; sleep 1 ;;
    esac
done
