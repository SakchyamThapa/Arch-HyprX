#!/bin/bash

# install.sh - Complete setup script for HyprX
# This script installs all packages and sets up symlinks for HyprX

set -e  # Exit on error
set -u  # Treat unset variables as errors

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root"
    exit 1
fi

# Your home and HyprX directories
HyprX="$HOME/HyprX"
CONFIG="$HOME/.config"

# ============================================================================
# PART 0: PREPARE SCRIPTS
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

chmod +x "$SCRIPT_DIR/scripts/package-list.sh" 2>/dev/null || true
chmod +x "$SCRIPT_DIR/scripts/install-node.sh" 2>/dev/null || true
chmod +x "$SCRIPT_DIR/scripts/install-tools.sh" 2>/dev/null || true

# ============================================================================
# PART 1: PACKAGE INSTALLATION
# ============================================================================

print_status "Starting package installation..."

# Update system first
print_status "Updating system packages..."
sudo pacman -Syu --noconfirm

# Install base-devel and git if not present (required for yay)
print_status "Installing base-devel and git..."
sudo pacman -S --needed --noconfirm base-devel git

# Check and install yay if not present
if ! command -v yay &> /dev/null; then
    print_status "yay not found. Installing yay from AUR..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
    print_success "yay installed successfully"
else
    print_status "yay is already installed"
fi

# Array of packages to install via pacman (from packages/pacman.txt)
PACMAN_PACKAGES=(
    # Core
    "base"
    "base-devel"
    "git"
    "sudo"
    "zsh"
    "man-db"
    "nano"
    "vim"
    "tree"
    "wget"
    "zip"
    "htop"
    "just"
    
    # Hyprland & Desktop
    "hyprland"
    "hyprpaper"
    "hyprsunset"
    "uwsm"
    "xdg-desktop-portal-hyprland"
    "xdg-utils"
    "xdg-user-dirs"
    "xorg-server"
    "xorg-xinit"
    "qt5-wayland"
    "qt6-wayland"
    "qt5-base"
    
    # Terminal & Shells
    "kitty"
    "zsh"
    
    # Status bar & Apps
    "waybar"
    "rofi"
    "wofi"
    "swaync"
    "dunst"
    
    # Tools
    "grim"
    "slurp"
    "brightnessctl"
    "cliphist"
    "wl-clipboard"
    "nwg-clipman"
    "nwg-look"
    "adw-gtk-theme"
    "ffmpeg"
    "fastfetch"
    "eza"
    
    # Networking
    "iwd"
    "wireless_tools"
    "openssh"
    "speedtest-cli"
    "networkmanager"
    
    # Audio/Video
    "pipewire"
    "pipewire-alsa"
    "pipewire-jack"
    "pipewire-pulse"
    "libpulse"
    "gst-plugin-pipewire"
    "wireplumber"
    "sof-firmware"
    "spotify-launcher"
    "ristretto"
    
    # Bluetooth
    "blueman"
    "bluez"
    "bluez-utils"
    
    # Graphics & Display
    "nvidia-open-dkms"
    "nvidia-utils"
    "libva-nvidia-driver"
    "amd-ucode"
    "linux-firmware"
    "libva-nvidia-driver"
    
    # File Managers & Media
    "dolphin"
    "nautilus"
    "mousepad"
    "baobab"
    
    # Dev Tools
    "neovim"
    "github-cli"
    "nodejs"
    "npm"
    "python"
    "python-pip"
    "python-virtualenv"
    
    # Browsers
    "firefox"
    "vivaldi"
    "vivaldi-ffmpeg-codecs"
    "brave-bin"
    
    # Communication
    "discord"
    "slack-desktop"
    "postman-bin"
    
    # Virtualization & Containers
    "docker"
    "docker-compose"
    "dkms"
    
    # System
    "sbctl"
    "efibootmgr"
    "smartmontools"
    "zram-generator"
    "power-profiles-daemon"
    "polkit-kde-agent"
    
    # Security
    "gdm"
    
    # Fonts
    "ttf-jetbrains-mono-nerd"
)

# Array of packages to install via yay (AUR) (from packages/aur.txt)
YAY_PACKAGES=(
    "visual-studio-code-bin"
    "yay"
    "brave-bin"
    "postman-bin"
    "slack-desktop"
    "discord"
    "dbeaver"
    "nwg-look"
    "adw-gtk-theme"
    "ristretto"
    "baobab"
    "ttf-jetbrains-mono-nerd"
)

# Install pacman packages
print_status "Installing packages from official repositories..."
for package in "${PACMAN_PACKAGES[@]}"; do
    print_status "Installing $package..."
    if sudo pacman -S --needed --noconfirm "$package"; then
        print_success "$package installed successfully"
    else
        print_error "Failed to install $package"
    fi
done

# Install yay packages
print_status "Installing packages from AUR..."
for package in "${YAY_PACKAGES[@]}"; do
    print_status "Installing $package from AUR..."
    if yay -S --needed --noconfirm "$package"; then
        print_success "$package installed successfully"
    else
        print_error "Failed to install $package from AUR"
    fi
done

# Create basic directories if they don't exist
print_status "Creating user directories..."
xdg-user-dirs-update

print_success "Package installation complete!"

# ============================================================================
# PART 1B: NODE.JS & TOOLS SETUP
# ============================================================================

print_status "Setting up Node.js and tools..."

# Install Node.js with nvm
if [ -f "$SCRIPT_DIR/scripts/install-node.sh" ]; then
    bash "$SCRIPT_DIR/scripts/install-node.sh"
fi

# Install other tools
if [ -f "$SCRIPT_DIR/scripts/install-tools.sh" ]; then
    bash "$SCRIPT_DIR/scripts/install-tools.sh"
fi

# ============================================================================
# PART 2: OH-MY-ZSH AND POWERLEVEL10K SETUP
# ============================================================================

# Optional: Install Oh My Zsh and Powerlevel10k
print_warning "Do you want to set up/update Oh My Zsh and Powerlevel10k? (y/n)"
read -r install_zsh
if [[ "$install_zsh" =~ ^[Yy]$ ]]; then
    # Check if Oh My Zsh is already installed
    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_status "Oh My Zsh is already installed at $HOME/.oh-my-zsh"
        print_warning "Do you want to:"
        echo "1) Keep existing installation and just install/update Powerlevel10k"
        echo "2) Reinstall Oh My Zsh (backup existing configuration)"
        echo "3) Skip Oh My Zsh setup"
        read -r zsh_choice

        case $zsh_choice in
            1)
                print_status "Keeping existing Oh My Zsh installation..."
                ;;
            2)
                print_status "Backing up existing Oh My Zsh configuration..."
                backup_dir="$HOME/ohmyzsh-backup-$(date +%Y%m%d-%H%M%S)"
                mv "$HOME/.oh-my-zsh" "$backup_dir"
                if [ -f "$HOME/.zshrc" ]; then
                    cp "$HOME/.zshrc" "$backup_dir/"
                fi
                print_success "Backed up to $backup_dir"

                print_status "Installing Oh My Zsh..."
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
                ;;
            3)
                print_status "Skipping Oh My Zsh installation..."
                ;;
        esac
    else
        print_status "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install/Update Powerlevel10k theme
    print_status "Setting up Powerlevel10k theme..."
    p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    if [ -d "$p10k_dir" ]; then
        print_status "Powerlevel10k already exists, updating..."
        (cd "$p10k_dir" && git pull)
    else
        print_status "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
    fi

    # Check if .zshrc exists and update theme if needed
    if [ -f "$HOME/.zshrc" ]; then
        # Backup .zshrc
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d-%H%M%S)"

        if grep -q "ZSH_THEME=" "$HOME/.zshrc"; then
            # Update existing theme
            sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
        else
            # Add theme if not present
            echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$HOME/.zshrc"
        fi
        print_success "Updated ZSH_THEME in .zshrc"
    fi

    # Check for existing Powerlevel10k configuration
    if [ -f "$HOME/.p10k.zsh" ]; then
        print_status "Found existing Powerlevel10k configuration at $HOME/.p10k.zsh"
        print_warning "Do you want to keep this configuration? (y/n)"
        read -r keep_p10k_config
        if [[ "$keep_p10k_config" =~ ^[Yy]$ ]]; then
            print_success "Keeping existing Powerlevel10k configuration"
        else
            print_warning "Configuration will be regenerated on next terminal start"
        fi
    fi

    print_success "Oh My Zsh and Powerlevel10k setup complete"
    print_warning "You may need to restart your terminal or run 'source ~/.zshrc' to apply changes"
fi

# ============================================================================
# PART 3: HyprX SYMLINK SETUP
# ============================================================================

print_status "Starting HyprX symlink setup..."

# Ensure HyprX directory exists
mkdir -p "$HyprX"

# List of config directories to symlink
apps=("hypr" "kitty" "rofi" "waybar" "swaync" "nvim")

for app in "${apps[@]}"; do
    # Check if the app directory exists in HyprX
    if [ -d "$HyprX/$app" ]; then
        print_status "Setting up symlink for $app..."

        # Handle existing config in .config
        if [ -e "$CONFIG/$app" ]; then
            if [ ! -L "$CONFIG/$app" ]; then
                # It's a regular directory/file, not a symlink
                print_warning "Found existing $app config at $CONFIG/$app"
                print_warning "Moving to $HyprX/$app (backup created)"
                mv "$CONFIG/$app" "$HyprX/$app.bak.$(date +%Y%m%d-%H%M%S)"
            else
                # It's an existing symlink, remove it
                print_warning "Removing old symlink $CONFIG/$app"
                rm "$CONFIG/$app"
            fi
        fi

        # Create the symlink
        ln -s "$HyprX/$app" "$CONFIG/$app"
        print_success "Created symlink for $app"
    else
        print_warning "Directory $HyprX/$app not found. Skipping..."
    fi
done

# ============================================================================
# PART 4: SYMLINK HOME FILES
# ============================================================================

# Symlink home HyprX
HOME_HyprX=(".zshrc" ".p10k.zsh" ".bashrc")
for file in "${HOME_HyprX[@]}"; do
    if [ -f "$HyprX/$file" ]; then
        print_status "Setting up symlink for $file..."
        if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
            print_warning "Backing up existing $HOME/$file to $HOME/$file.backup"
            mv "$HOME/$file" "$HOME/$file.backup"
        fi
        if [ -L "$HOME/$file" ]; then
            rm "$HOME/$file"
        fi
        ln -s "$HyprX/$file" "$HOME/$file"
        print_success "Created symlink for $file"
    fi
done

print_success "HyprX symlink setup complete!"

# ============================================================================
# PART 5: NEOVIM & PYTHON SETUP
# ============================================================================

print_status "Setting up Neovim with Python tools..."

# Ensure Neovim config directory exists
if [ ! -d "$HyprX/nvim" ]; then
    print_warning "Neovim config directory not found at $HyprX/nvim"
    print_status "Creating Neovim config directory..."
    mkdir -p "$HyprX/nvim/lua/plugins"
fi

# Symlink nvim if not already done
if [ -d "$HyprX/nvim" ] && [ ! -L "$CONFIG/nvim" ]; then
    print_status "Setting up symlink for nvim..."
    if [ -e "$CONFIG/nvim" ]; then
        mv "$CONFIG/nvim" "$CONFIG/nvim.bak.$(date +%Y%m%d-%H%M%S)"
    fi
    ln -s "$HyprX/nvim" "$CONFIG/nvim"
    print_success "Created symlink for nvim"
fi

# Install Python packages needed for Neovim
print_status "Installing Python packages..."
pip install --user black flake8 ruff 2>/dev/null || print_warning "pip install failed, skipping..."

# Install Neovim plugins (LazyVim)
print_status "Installing Neovim plugins (LazyVim)..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || print_warning "Lazy sync failed, run :Lazy sync manually"

# Install Mason tools (LSP, formatters, linters)
print_status "Installing Mason tools (LSP, formatters, linters)..."
nvim --headless "+MasonInstallAll" +qa 2>/dev/null || print_warning "Mason install failed, run :MasonInstallAll manually"

print_success "Neovim setup complete!"

# ============================================================================
# PART 5B: BATTERY CONSERVATION SCRIPT
# ============================================================================

print_status "Setting up battery conservation script..."
mkdir -p "$HOME/.local/bin"
if [ -f "$SCRIPT_DIR/scripts/battery-limit.sh" ]; then
    cp "$SCRIPT_DIR/scripts/battery-limit.sh" "$HOME/.local/bin/battery-limit.sh"
    chmod +x "$HOME/.local/bin/battery-limit.sh"
    print_success "Battery limit script installed to ~/.local/bin/battery-limit.sh"
fi

# Create aura-battery wrapper script
print_status "Creating aura-battery wrapper..."
cat > "$HOME/.local/bin/aura-battery" << 'EOF'
#!/bin/bash
PATH_TO="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

case "$1" in
    1|on)
        echo 1 | sudo tee "$PATH_TO" > /dev/null
        echo "Battery: 80% limit enabled"
        ;;
    0|off)
        echo 0 | sudo tee "$PATH_TO" > /dev/null
        echo "Battery: 100% charging enabled"
        ;;
    status|s)
        status=$(cat "$PATH_TO")
        [ "$status" = "1" ] && echo "ON (80%)" || echo "OFF (100%)"
        ;;
    *)
        echo "Usage: aura-battery [1|0|status]"
        echo "  1/on   - Enable 80% limit"
        echo "  0/off  - Disable (100%)"
        echo "  status - Check status"
        ;;
esac
EOF
chmod +x "$HOME/.local/bin/aura-battery"

# Create symlink in /usr/local/bin so sudo can find it
print_status "Creating symlink for sudo aura-battery..."
if [ ! -f /usr/local/bin/aura-battery ]; then
    ln -sf "$HOME/.local/bin/aura-battery" /usr/local/bin/aura-battery
    print_success "Symlink created: /usr/local/bin/aura-battery"
fi

print_success "Battery conservation setup complete!"

# ============================================================================
# PART 6: EXPORT PACKAGE LISTS
# ============================================================================

print_status "Would you like to update package lists? (y/n)"
print_status "This exports your current packages to HyprX/packages/ for backup"
read -r update_packages
if [[ "$update_packages" =~ ^[Yy]$ ]]; then
    if [ -f "$SCRIPT_DIR/scripts/package-list.sh" ]; then
        bash "$SCRIPT_DIR/scripts/package-list.sh"
        print_success "Package lists updated!"
    fi
fi

# ============================================================================
# PART 7: FINAL TOUCHES
# ============================================================================

# Check if we're on Hyprland and offer to reload
if [ "$XDG_SESSION_DESKTOP" = "hyprland" ]; then
    print_warning "Do you want to reload Hyprland configuration? (y/n)"
    read -r reload_hypr
    if [[ "$reload_hypr" =~ ^[Yy]$ ]]; then
        hyprctl reload
        print_success "Hyprland reloaded"
    fi
fi

# Final summary
print_success "======================================"
print_success "Setup completed successfully!"
print_success "======================================"
print_status "Installed packages:"
echo -e "${GREEN}Official repositories:${NC} ${PACMAN_PACKAGES[*]}"
echo -e "${GREEN}AUR packages:${NC} ${YAY_PACKAGES[*]}"
echo ""
print_status "Symlinks created for: ${apps[*]} and ${HOME_HyprX[*]}"
echo ""
print_warning "Next steps:"
echo "  1. Restart your terminal or run 'source ~/.zshrc' to apply Zsh changes"
echo "  2. If you're using Powerlevel10k for the first time, it will prompt for configuration"
echo "  3. Run 'p10k configure' if you want to reconfigure Powerlevel10k"
echo "  4. Review your config files in ~/.config/ to ensure everything works"
echo "  5. For Neovim Copilot: Run ':Copilot auth' to authenticate with GitHub"
echo "  6. Optionally set: export COPILOT_AUTHORIZATION_TOKEN=<your-token> in .zshrc"
