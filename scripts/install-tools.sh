#!/bin/bash

# install-tools.sh - Install pip packages and other user-level tools
# This script installs Python packages and other user tools

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HyprX="$HOME/HyprX"

print_status "Installing Python packages..."

# Install pip packages from list
PIP_PACKAGES=(
    "speedtest-cli"
)

for package in "${PIP_PACKAGES[@]}"; do
    print_status "Installing $package..."
    pip install --user "$package" 2>/dev/null || print_warning "$package failed, skipping..."
done

print_success "Python tools setup complete!"

print_status "Setting up Go..."
if command -v go &> /dev/null; then
    print_status "Go is already installed: $(go version)"
fi

print_status "Setting up Java..."
if command -v java &> /dev/null; then
    print_status "Java is already installed"
fi

print_success "All tools setup complete!"
