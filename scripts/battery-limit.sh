#!/bin/bash
# Battery Conservation Mode for Lenovo Legion
# Limits battery charge to 80% to preserve battery health

CONSERVATION_MODE_PATH='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'

print_usage() {
    echo "Usage: $0 [on|off|status]"
    echo ""
    echo "  on     - Enable conservation mode (80% limit)"
    echo "  off    - Disable conservation mode (100% charge)"
    echo "  status - Show current status"
}

get_status() {
    if [ ! -f "$CONSERVATION_MODE_PATH" ]; then
        echo "Error: conservation_mode file not found"
        exit 1
    fi
    
    status=$(cat "$CONSERVATION_MODE_PATH")
    if [ "$status" = "1" ]; then
        echo "Conservation mode: ON (80% limit)"
    elif [ "$status" = "0" ]; then
        echo "Conservation mode: OFF (100% charge)"
    else
        echo "Status: Unknown ($status)"
    fi
}

enable_bcm() {
    echo 1 | sudo tee "$CONSERVATION_MODE_PATH" > /dev/null
    echo "Conservation mode enabled - Battery will charge to 80%"
}

disable_bcm() {
    echo 0 | sudo tee "$CONSERVATION_MODE_PATH" > /dev/null
    echo "Conservation mode disabled - Battery will charge to 100%"
}

main() {
    local key="$1"
    
    case "$key" in
        on)
            enable_bcm
            ;;
        off)
            disable_bcm
            ;;
        status|s)
            get_status
            ;;
        -h|--help)
            print_usage
            ;;
        *)
            print_usage
            exit 1
            ;;
    esac
}

main "$@"



# Reverse ALL changes made during our HyprX session. Do NOT delete files - only revert their content changes to original state. Read each file first before making changes.
# CHANGES TO REVERT:
# 1. SCRIPTS - Delete these files if they exist:
#    - ~/HyprX/scripts/package-list.sh
#    - ~/HyprX/scripts/backup.sh
#    - ~/HyprX/scripts/install-node.sh
#    - ~/HyprX/scripts/install-tools.sh
#    - ~/HyprX/scripts/battery-limit.sh
# 2. PACKAGES - Delete this folder if it exists:
#    - ~/HyprX/packages/ (delete entire folder with all .txt files)
# 3. INSTALL.SH - Revert these changes:
#    - Find the PACMAN_PACKAGES array that contains ~80+ packages (lines ~72-212)
#    - Replace entire array back to original minimal ~20 packages:
#      PACMAN_PACKAGES=(
#          "tree" "github-cli" "exa" "fastfetch" "sbctl" "hyprland" "kitty" 
#          "wl-clipboard" "nwg-clipman" "swww" "hyprpaper" "rofi" 
#          "waybar" "swaync" "man" "xdg-user-dirs" "zsh" "hyprsunset" "man" 
#          "speedtest-cli" "brightnessctl" "blueman" "bluez" "bluez-utils" 
#          "neovim" "python" "python-pip"
#      )
#    - Find YAY_PACKAGES array and replace with original:
#      YAY_PACKAGES=( "visual-studio-code-bin" )
#    - Remove sections: "PART 1B: NODE.JS & TOOLS SETUP", "PART 5B: BATTERY CONSERVATION SCRIPT"
#    - Remove "scripts/package-list.sh", "scripts/install-node.sh", "scripts/install-tools.sh" execution calls
#    - Remove battery-limit.sh copy/install section
# 4. .ZSHRC - Remove only this line from ~/HyprX/.zshrc:
#    - Remove: alias aura="hyprctl"
#    - Keep all other content intact
# 5. WAYBAR CONFIG - Revert only workspace 5 icon in ~/HyprX/waybar/config.jsonc:
#    - Change "5": "" back to "5": ""
#    - Keep all other content intact
# 6. LOCAL BIN - Delete if exists:
#    - ~/.local/bin/battery-limit.sh
# IMPORTANT: 
# - Read each file BEFORE editing to understand current state
# - Only remove the specific additions listed above
# - Do NOT delete hyprland.conf, monitors.conf, keybinds.conf or any original config files
# - Do NOT modify git history or commit anything
# ---
# **END PROMPT**

