#!/bin/bash
# bootstrap-tools.sh
# 🛠️ Installs DevSecOps CLI tools (Terraform, AWS CLI, LSD, pwsh, etc.)

set -e

echo "🔧 Updating APT packages..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing base dependencies..."
sudo apt install -y \
  curl wget git unzip gnupg ca-certificates apt-transport-https software-properties-common \
  jq build-essential python3-pip python3-venv lsb-release

# === Ensure ~/.local/bin and /snap/bin are in PATH ===
if ! grep -q 'PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q '/snap/bin' <<< "$PATH"; then
  echo 'export PATH="$PATH:/snap/bin"' >> "$HOME/.bashrc"
  export PATH="$PATH:/snap/bin"
fi

# === Terraform ===
if ! command -v terraform &>/dev/null; then
  echo "📐 Installing Terraform..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform -y
else
  echo "✅ Terraform already installed: $(terraform version | head -n 1)"
fi

# === AWS CLI ===
if ! command -v aws &>/dev/null; then
  echo "☁️ Installing AWS CLI..."
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
  unzip -q /tmp/awscliv2.zip -d /tmp
  sudo /tmp/aws/install
else
  echo "✅ AWS CLI already installed: $(aws --version)"
fi

# === Pre-commit ===
echo "🪝 Installing pre-commit via pip..."
pip3 install --user --upgrade pre-commit
echo "✅ pre-commit version: $(~/.local/bin/pre-commit --version)"

# === LSD via Snap ===
if ! command -v lsd &>/dev/null; then
  echo "📁 Installing lsd via snap..."
  sudo snap install lsd
else
  echo "✅ lsd already installed: $(lsd --version)"
fi

# === PowerShell via Snap ===
if ! command -v pwsh &>/dev/null; then
  echo "🐚 Installing PowerShell via snap..."
  sudo snap install powershell --classic
else
  echo "✅ PowerShell already installed: $(pwsh --version)"
fi

echo "✅ All core tools installed and available in PATH"

