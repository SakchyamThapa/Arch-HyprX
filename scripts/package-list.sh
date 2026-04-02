#!/bin/bash

# package-list.sh - Export current packages to text files
# Run this to backup your current package lists

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_DIR="$SCRIPT_DIR/../packages"

mkdir -p "$PACKAGES_DIR"

print_status() {
    echo "[INFO] $1"
}

print_success() {
    echo "[SUCCESS] $1"
}

print_status "Exporting packages..."

# Export pacman packages (explicitly installed, exclude dependencies)
print_status "Exporting pacman packages..."
pacman -Qeq > "$PACKAGES_DIR/pacman.txt"
print_success "Exported to packages/pacman.txt ($(wc -l < "$PACKAGES_DIR/pacman.txt") packages)"

# Export yay (AUR) packages
print_status "Exporting AUR packages..."
pacman -Qmq > "$PACKAGES_DIR/aur.txt"
print_success "Exported to packages/aur.txt ($(wc -l < "$PACKAGES_DIR/aur.txt") packages)"

# Export pip user packages
print_status "Exporting pip packages..."
pip list --user 2>/dev/null | awk 'NR>2 {print $1}' > "$PACKAGES_DIR/pip.txt" || touch "$PACKAGES_DIR/pip.txt"
print_success "Exported to packages/pip.txt ($(wc -l < "$PACKAGES_DIR/pip.txt") packages)"

# Export npm global packages (exclude corepack which comes with node)
print_status "Exporting npm global packages..."
if command -v npm &> /dev/null; then
    npm list -g --depth=0 2>/dev/null | awk 'NR>3 {print $2}' | sed 's/@.*//' | grep -v '^$' > "$PACKAGES_DIR/npm.txt" || touch "$PACKAGES_DIR/npm.txt"
else
    touch "$PACKAGES_DIR/npm.txt"
fi
print_success "Exported to packages/npm.txt ($(wc -l < "$PACKAGES_DIR/npm.txt") packages)"

# Export cargo packages
print_status "Exporting cargo packages..."
if command -v cargo &> /dev/null; then
    cargo install --list 2>/dev/null | grep '^[[:alnum:]]' | awk '{print $1}' > "$PACKAGES_DIR/cargo.txt" || touch "$PACKAGES_DIR/cargo.txt"
else
    touch "$PACKAGES_DIR/cargo.txt"
fi
print_success "Exported to packages/cargo.txt ($(wc -l < "$PACKAGES_DIR/cargo.txt") packages)"

print_success "All packages exported successfully!"
echo ""
echo "Files created:"
ls -la "$PACKAGES_DIR"
