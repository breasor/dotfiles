#!/bin/bash
# bootstrap-posh-theme.sh
# 🎨 Installs and configures Oh My Posh for WSL Bash

set -e

POSH_BIN="$HOME/.local/bin/oh-my-posh"
THEME_DIR="$HOME/.poshthemes"
THEME_NAME="devsecops.omp.json"
BASHRC="$HOME/.bashrc"

# 1. Install Oh My Posh binary
if [ ! -f "$POSH_BIN" ]; then
  echo "⬇️ Installing Oh My Posh..."
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
else
  echo "✅ Oh My Posh already installed at $POSH_BIN"
fi

# 2. Ensure theme folder exists
mkdir -p "$THEME_DIR"

# 3. Create a basic DevSecOps theme
cat > "$THEME_DIR/$THEME_NAME" <<'EOF'
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "final_space": true,
  "console_title": true,
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "type": "session",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#007ACC"
        },
        {
          "type": "venv",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#2D2D2D",
          "properties": {
            "prefix": "🐍 ",
            "display_mode": "context"
          }
        },
        {
          "type": "terraform",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#5F00AF",
          "properties": {
            "prefix": "🏗 ",
            "display_mode": "workspace"
          }
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#0C7D9D",
          "properties": {
            "display_status": true,
            "display_stash_count": true,
            "display_upstream_icon": true
          }
        },
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "",
          "foreground": "#ffffff",
          "background": "#44475a",
          "properties": {
            "style": "folder"
          }
        },
        {
          "type": "time",
          "style": "plain",
          "foreground": "#999999",
          "properties": {
            "format": "15:04:05"
          }
        }
      ]
    }
  ]
}
EOF

# 4. Inject into .bashrc if not already present
if ! grep -q "oh-my-posh init bash" "$BASHRC"; then
  echo "🎨 Adding Oh My Posh load logic to $BASHRC"
  cat <<EOF >> "$BASHRC"

# === Oh My Posh Prompt ===
export POSH_THEME=$THEME_DIR/$THEME_NAME
eval "\$($POSH_BIN init bash --config \$POSH_THEME)"
EOF
else
  echo "ℹ️ Oh My Posh already configured in $BASHRC"
fi

echo "🔁 Reloading shell with theme..."
source "$BASHRC"

echo "✅ Oh My Posh installed and themed with DevSecOps config"

