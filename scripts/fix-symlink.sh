#!/bin/bash
# Quick fix to create symlink for aura-battery
# Run this manually: bash ~/HyprX/scripts/fix-symlink.sh

ln -sf /home/aura/.local/bin/aura-battery /usr/local/bin/aura-battery
echo "Symlink created!"
