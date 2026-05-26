# HyprX — Hyprland Dotfiles

Personal Hyprland dotfiles and installation automation for Arch Linux.

## Quick Install

```bash
# Clone the repo
git clone https://github.com/SakchyamThapa/Arch-HyprX ~/HyprX
cd ~/HyprX

# Full install (packages, symlinks, configs)
./install.sh

# Or for non-interactive / automated installs:
./install.sh -y
```

## Manual Symlink Setup

If you already have the packages installed:

```bash
chmod +x symlink.sh && ./symlink.sh
```

## What It Sets Up

| Component | Config | Description |
|-----------|--------|-------------|
| **Hyprland** | `hypr/` | Window manager, keybinds, monitors, wallpaper, lockscreen |
| **Kitty** | `kitty/` | Terminal emulator |
| **Waybar** | `waybar/` | Status bar |
| **Rofi** | `rofi/` | App launcher + wallpaper picker (70+ styles) |
| **Swaync** | `swaync/` | Notification daemon (Catppuccin themed) |
| **Neovim** | `nvim/` | LazyVim-based config (LSP, autocomplete, AI, etc.) |
| **ZSH** | `.zshrc` | Powerlevel10k theme, custom `aura` command aliases |

## After Install

1. **Reboot** or start Hyprland: `uwsm start hyprland`
2. If monitors don't work, check `~/.config/hypr/monitors.conf`
3. Set wallpaper: **Super+Ctrl+W** opens the wallpaper picker
4. For Neovim: `nvim` will auto-install plugins via LazyVim

## Keybinds

| Key | Action |
|-----|--------|
| **Alt+Space** | App launcher (rofi) |
| **Super+Q** | Close window |
| **Super+T** | Open terminal |
| **Super+E** | File manager |
| **Super+L** | Lock screen |
| **Super+Ctrl+W** | Wallpaper picker |
| **Super+Shift+W** | WiFi menu |
| **Super+grave** | Screenshot (area) |
