#!/bin/bash
# bootstrap-venvs.sh
# 🧪 Creates isolated venvs for DevSecOps tools: Checkov + TruffleHog

set -e

VENV_DIR="$HOME/.venvs"
CHECKOV_VENV="$VENV_DIR/checkov"
TRUFFLEHOG_VENV="$VENV_DIR/trufflehog"

echo "📁 Creating venv directory at $VENV_DIR..."
mkdir -p "$VENV_DIR"

# --- Checkov Venv ---
if [ ! -d "$CHECKOV_VENV" ]; then
  echo "🔍 Creating Checkov venv..."
  python3 -m venv "$CHECKOV_VENV"
  source "$CHECKOV_VENV/bin/activate"
  pip install --upgrade pip
  pip install "checkov>=3.2.0,<4.0.0"
  echo "✅ Checkov installed: $(checkov --version)"
  deactivate
else
  echo "✅ Checkov venv already exists"
fi

# --- TruffleHog V2 Venv (MIT-licensed) ---
if [ ! -d "$TRUFFLEHOG_VENV" ]; then
  echo "🕵️ Creating TruffleHog venv..."
  python3 -m venv "$TRUFFLEHOG_VENV"
  source "$TRUFFLEHOG_VENV/bin/activate"
  pip install --upgrade pip
  pip install "trufflehog==2.2.1"
  echo "✅ TruffleHog installed: $(trufflehog --version)"
  deactivate
else
  echo "✅ TruffleHog venv already exists"
fi

echo "🔗 Tip: use aliases like:"
echo "  source $CHECKOV_VENV/bin/activate && checkov -d ."
echo "  source $TRUFFLEHOG_VENV/bin/activate && trufflehog filesystem ."

