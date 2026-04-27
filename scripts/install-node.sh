#!/bin/bash

# install-node.sh - Install Node.js with nvm and global packages
# This script installs nvm, node versions, and global npm packages

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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HyprX="$HOME/HyprX"

source "$HyprX/packages/npm.txt" 2>/dev/null || NPM_PACKAGES="pnpm"

print_status "Setting up Node.js with nvm..."

# Install nvm if not present
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    print_status "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
    print_status "nvm already installed"
fi

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js versions
NODE_VERSIONS=("24.14.1")

for version in "${NODE_VERSIONS[@]}"; do
    print_status "Installing Node.js v$version..."
    nvm install "$version" 2>/dev/null || nvm install "$version"
    nvm alias default "$version" 2>/dev/null || true
done

# Set default node version
nvm use default 24.14.1 2>/dev/null || true

print_status "Installing global npm packages..."
# Install pnpm
if command -v pnpm &> /dev/null; then
    print_status "pnpm already installed"
else
    npm install -g pnpm
fi

print_success "Node.js setup complete!"
echo "Node version: $(node --version)"
echo "npm version: $(npm --version)"
echo "pnpm version: $(pnpm --version)"
