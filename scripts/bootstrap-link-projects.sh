#!/bin/bash
# bootstrap-link-projects.sh
# 📅 2025-07-24
# 🔗 Link Windows Projects folder into WSL home for easier access

WINDOWS_PROJECTS="/mnt/c/Users/brett.reasor/Projects"
TARGET_LINK="$HOME/Projects"
SHELL_RC="$HOME/.bashrc"

echo "🔍 Checking if Windows path exists: $WINDOWS_PROJECTS"
if [ ! -d "$WINDOWS_PROJECTS" ]; then
    echo "❌ ERROR: Windows Projects folder not found at $WINDOWS_PROJECTS"
    exit 1
fi

# Remove existing if not a symlink
if [ -e "$TARGET_LINK" ] && [ ! -L "$TARGET_LINK" ]; then
    echo "⚠️  Found existing ~/Projects folder (not a symlink). Backing it up to ~/Projects.bak"
    mv "$TARGET_LINK" "$HOME/Projects.bak"
fi

# Create symlink
if [ ! -L "$TARGET_LINK" ]; then
    echo "🔗 Creating symlink: $TARGET_LINK → $WINDOWS_PROJECTS"
    ln -s "$WINDOWS_PROJECTS" "$TARGET_LINK"
else
    echo "✅ Symlink already exists: $TARGET_LINK"
fi

# Add auto-relink to shell profile if not present
if ! grep -q "bootstrap symlink for ~/Projects" "$SHELL_RC"; then
    echo "📌 Adding auto-relink logic to $SHELL_RC"

    cat <<EOF >> "$SHELL_RC"

# bootstrap symlink for ~/Projects to Windows
if [ ! -L "\$HOME/Projects" ] && [ -d "/mnt/c/Users/brett.reasor/Projects" ]; then
  ln -s /mnt/c/Users/brett.reasor/Projects "\$HOME/Projects"
fi
EOF
else
    echo "🔁 Auto-relink logic already present in $SHELL_RC"
fi

echo "✅ Setup complete. Run: source $SHELL_RC"

