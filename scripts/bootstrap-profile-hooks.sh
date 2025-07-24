#!/bin/bash
# bootstrap-profile-hooks.sh
# 🧩 Ensures .bashrc loads aliases, oh-my-posh, and DevSecOps configs

set -e

BASHRC="$HOME/.bashrc"
ALIAS_BLOCK="# Load custom aliases"
POSH_BLOCK="# === Oh My Posh Prompt ==="
ALIAS_FILE="$HOME/.bash_aliases"
POSH_THEME="$HOME/.poshthemes/devsecops.omp.json"
POSH_BIN="$HOME/.local/bin/oh-my-posh"

# 1. Ensure .bash_aliases exists
if [ ! -f "$ALIAS_FILE" ]; then
  echo "📄 Creating empty ~/.bash_aliases"
  touch "$ALIAS_FILE"
fi

# 2. Inject alias loader into .bashrc if missing
if ! grep -q "$ALIAS_BLOCK" "$BASHRC"; then
  echo "📌 Adding alias loader to $BASHRC"
  cat <<EOF >> "$BASHRC"

$ALIAS_BLOCK
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
else
  echo "✅ Alias loader already in $BASHRC"
fi

# 3. Inject Oh My Posh prompt if not present
if [ -f "$POSH_BIN" ] && [ -f "$POSH_THEME" ]; then
  if ! grep -q "$POSH_BLOCK" "$BASHRC"; then
    echo "🎨 Adding Oh My Posh init block to $BASHRC"
    cat <<EOF >> "$BASHRC"

$POSH_BLOCK
export POSH_THEME=$POSH_THEME
eval "\$($POSH_BIN init bash --config \$POSH_THEME)"
EOF
  else
    echo "✅ Oh My Posh already configured in $BASHRC"
  fi
else
  echo "⚠️ Skipping Oh My Posh injection — theme or binary missing"
fi

# 4. Reload shell
echo "🔁 Reloading profile..."
source "$BASHRC"

echo "✅ .bashrc profile hooks fully configured."

