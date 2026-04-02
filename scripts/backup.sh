#!/bin/bash

# backup.sh - Quick backup of all packages to HyprX
# Run this to export your current package lists for git

echo "========================================"
echo "  Backing up packages to HyprX"
echo "========================================"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run the package list export
if [ -f "$SCRIPT_DIR/package-list.sh" ]; then
    bash "$SCRIPT_DIR/package-list.sh"
else
    echo "Error: package-list.sh not found"
    exit 1
fi

echo ""
echo "========================================"
echo "  Package lists saved!"
echo "========================================"
echo ""
echo "To commit to git:"
echo "  cd ~/HyprX"
echo "  git add packages/"
echo "  git commit -m 'Update package lists'"
echo "  git push"
echo ""
