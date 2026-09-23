#!/usr/bin/env bash

set -Eeuo pipefail

TARGET="${1:-}"

THEMES="$HOME/.themes"
ICONS="$HOME/.local/share/icons"

remove_pattern() {

    local directory="$1"
    local pattern="$2"

    [[ -d "$directory" ]] || return 0

    find "$directory" \
        -maxdepth 1 \
        -type d \
        -name "$pattern" \
        -exec rm -rf {} \; \
        2>/dev/null || true
}

remove_windows11() {

    echo
    echo "Removing Windows 11 themes..."

    remove_pattern "$THEMES" "Win11*"
    remove_pattern "$HOME/.local/share/themes" "Win11*"

    remove_pattern "$ICONS" "Win11*"

    rm -rf \
        "$HOME/.local/share/mint-cinnamon-themes/sources/Win11-gtk-theme" \
        "$HOME/.local/share/mint-cinnamon-themes/sources/Win11-icon-theme"

    echo "Windows 11 theme removed."
}

remove_macos() {

    echo
    echo "Removing WhiteSur themes..."

    remove_pattern "$THEMES" "WhiteSur*"
    remove_pattern "$HOME/.local/share/themes" "WhiteSur*"

    remove_pattern "$ICONS" "WhiteSur*"

    rm -rf \
        "$HOME/.local/share/mint-cinnamon-themes/sources/WhiteSur-gtk-theme" \
        "$HOME/.local/share/mint-cinnamon-themes/sources/WhiteSur-icon-theme"

    echo "WhiteSur theme removed."
}

remove_chromeos() {

    echo
    echo "Removing ChromeOS themes..."

    remove_pattern "$THEMES" "ChromeOS*"
    remove_pattern "$HOME/.local/share/themes" "ChromeOS*"

    remove_pattern "$ICONS" "Vector*"
    remove_pattern "$ICONS" "Ozone*"

    rm -rf \
        "$HOME/.local/share/mint-cinnamon-themes/sources/ChromeOS-theme" \
        "$HOME/.local/share/mint-cinnamon-themes/sources/Ozone-icons"

    echo "ChromeOS theme removed."
}

case "$TARGET" in

    windows11)
        remove_windows11
        ;;

    macos)
        remove_macos
        ;;

    chromeos)
        remove_chromeos
        ;;

    all)

        echo
        echo "This will remove Windows 11, WhiteSur and ChromeOS"
        echo "themes managed by this project."
        echo

        read -rp "Type YES to continue: " confirm

        if [[ "$confirm" == "YES" ]]; then
            remove_windows11
            remove_macos
            remove_chromeos
        else
            echo "Cancelled."
        fi

        ;;

    *)
        echo "Usage:"
        echo "  uninstall.sh windows11"
        echo "  uninstall.sh macos"
        echo "  uninstall.sh chromeos"
        echo "  uninstall.sh all"
        exit 1
        ;;

esac

echo
read -rp "Press Enter to continue..."
