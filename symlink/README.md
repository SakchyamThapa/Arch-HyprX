Step 1 — Move the existing configs into HyprX
mv ~/ .config/hypr ~/HyprX/
mv ~/ .config/kitty ~/HyprX/

After this, your ~/HyprX will contain:

~/HyprX/
├── hypr/
└── kitty/

And ~/.config will no longer have hypr or kitty.

Step 2 — Create symlinks
ln -s ~/HyprX/hypr ~/.config/hypr
ln -s ~/HyprX/kitty ~/.config/kitty

Now the directory structure is effectively:

~/.config/
├── hypr -> ~/HyprX/hypr
└── kitty -> ~/HyprX/kitty
Step 3 — Test

Check that the symlinks work:

ls -l ~/.config
# hypr -> /home/darkkphoenyx/HyprX/hypr
# kitty -> /home/darkkphoenyx/HyprX/kitty

Follow the symlink to see the real files:

cd ~/.config/hypr
pwd -P
# /home/darkkphoenyx/HyprX/hypr

pwd -P confirms the real path, not the symlink.

✅ Now any edits you make in ~/HyprX/hypr or ~/HyprX/kitty are automatically reflected in ~/.config because of the symlink.

If you want, I can also give you a single command that moves all existing apps inside .config into HyprX and symlinks them automatically, so you don’t have to do it one by one. It’s very clean for HyprX management.

Do you want me to do that?

ok so now i want the install.sh also

Perfect — we can make an install.sh script that automates setting up your HyprX: moves existing configs, creates symlinks, and ensures everything is clean. Here’s a safe version tailored for your setup:

install.sh
#!/usr/bin/env bash
set -e  # exit if any command fails
set -u  # treat unset variables as errors

# Your home and HyprX directories
HyprX="$HOME/HyprX"
CONFIG="$HOME/.config"

echo "Starting HyprX setup..."

# Ensure HyprX directory exists
mkdir -p "$HyprX"

# List of apps to symlink
apps=("hypr" "kitty")

for app in "${apps[@]}"; do
    if [ -e "$CONFIG/$app" ] && [ ! -L "$CONFIG/$app" ]; then
        echo "Moving existing $app config into HyprX..."
        mv "$CONFIG/$app" "$HyprX/$app"
    fi

    # Remove existing symlink if any
    if [ -L "$CONFIG/$app" ]; then
        echo "Removing old symlink $CONFIG/$app"
        rm "$CONFIG/$app"
    fi

    # Create symlink
    echo "Creating symlink for $app..."
    ln -s "$HyprX/$app" "$CONFIG/$app"
done

echo "HyprX setup complete!"
How to use it

Save this file as install.sh in your home or in ~/HyprX.

Make it executable:

chmod +x install.sh

Run it:

./install.sh

✅ What it does:

Moves your existing hypr and kitty configs into ~/HyprX if they aren’t already there.

Replaces any old symlinks with fresh ones.

Ensures your .config always points to your HyprX.
