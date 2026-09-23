#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

BACKUP_DIR="$HOME/.local/share/mint-cinnamon-themes/backups"
mkdir -p "$BACKUP_DIR"

create_backup() {
    clear
    echo
    echo -e "${CYAN}${BOLD}  CREATE BACKUP${RESET}"
    echo -e "${GRAY}  This will save your current Cinnamon themes, panel layout, and settings.${RESET}\n"
    
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="$BACKUP_DIR/cinnamon_$timestamp.dconf"
    
    info "Backing up Cinnamon settings..."
    
    # گرفتن بکاپ از کل تنظیمات سینامون
    dconf dump /org/cinnamon/ > "$backup_file"
    
    if [[ -s "$backup_file" ]]; then
        success "Backup created successfully!"
        echo -e "  ${GRAY}Saved at: $backup_file${RESET}"
    else
        error_msg "Failed to create backup."
        rm -f "$backup_file"
    fi
    pause_screen
}

restore_backup() {
    clear
    echo
    echo -e "${CYAN}${BOLD}  RESTORE BACKUP${RESET}"
    echo -e "${GRAY}  Choose a backup to restore your previous Cinnamon settings.${RESET}\n"

    # پیدا کردن فایل‌های بکاپ
    local backups=("$BACKUP_DIR"/*.dconf)
    
    # اگر فایلی پیدا نشد (مقدار اول ستاره است)
    if [[ ! -e "${backups[0]}" ]]; then
        warning "No backups found in $BACKUP_DIR"
        pause_screen
        return
    fi

    echo -e "  ${WHITE}Available Backups:${RESET}\n"
    
    local i=1
    for backup in "${backups[@]}"; do
        local filename=$(basename "$backup")
        echo -e "  [${CYAN}$i${RESET}] $filename"
        ((i++))
    done
    echo -e "\n  [${CYAN}0${RESET}] Cancel\n"

    read -rp "  Select a backup to restore: " choice

    if [[ "$choice" -eq 0 ]]; then
        return
    elif [[ "$choice" -gt 0 ]] && [[ "$choice" -le "${#backups[@]}" ]]; then
        local selected_file="${backups[$((choice-1))]}"
        
        info "Restoring from $(basename "$selected_file")..."
        dconf load /org/cinnamon/ < "$selected_file"
        
        success "Settings restored successfully!"
        warning "You may need to restart Cinnamon (Alt+F2 -> type 'r' -> Enter) for all changes to take effect."
    else
        error_msg "Invalid selection."
    fi
    pause_screen
}

while true; do
    clear
    echo
    echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}${BOLD}║                 BACKUP & RESTORE                     ║${RESET}"
    echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${RESET}\n"

    echo -e "  [${GREEN}1${RESET}] 💾 Create New Backup"
    echo -e "  [${YELLOW}2${RESET}] 🔄 Restore from Backup"
    echo -e "  [${CYAN}0${RESET}] ← Back\n"

    read -rp "  Select an option: " choice

    case "$choice" in
        1) create_backup ;;
        2) restore_backup ;;
        0) break ;;
        *) warning "Invalid option."; sleep 1 ;;
    esac
done
