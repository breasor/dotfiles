#!/bin/bash
# bootstrap-aliases.sh
# 🛠️ Sets up DevSecOps-focused .bash_aliases

set -e

ALIAS_FILE="$HOME/.bash_aliases"
BASHRC_FILE="$HOME/.bashrc"

echo "🔧 Writing DevSecOps aliases to $ALIAS_FILE..."

cat > "$ALIAS_FILE" <<'EOF'
# ~/.bash_aliases
# DevSecOps WSL Alias Pack 🛠️

# === Navigation Shortcuts ===
alias proj='cd ~/Projects'
alias ps='cd ~/Projects/scripts/powershell'
alias tfmod='cd ~/Projects/terraform/modules'
alias gha='cd ~/Projects/.github/workflows'

# === Git ===
alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate --all'
alias gc='git commit -v'
alias gaa='git add --all'
alias gp='git push'
alias gpo='git push origin HEAD'
alias gpl='git pull --rebase'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gclean='git clean -fd && git reset --hard'

# === Terraform ===
alias tf='terraform'
alias tfinit='terraform init'
alias tfval='terraform validate'
alias tfplan='terraform plan -out=tf.plan'
alias tfapply='terraform apply tf.plan'
alias tfdestroy='terraform destroy'
alias tffmt='terraform fmt -recursive'
alias tfclean='rm -rf .terraform tf.plan terraform.tfstate*'

# === Python / Virtualenv ===
alias venv='python3 -m venv .venv && source .venv/bin/activate'
alias act='source .venv/bin/activate'
alias deact='deactivate'
alias pipup='pip install --upgrade pip setuptools wheel'

# === DevSecOps Tools ===
alias ck='source ~/.venvs/checkov/bin/activate && checkov -d .'
alias thog='source ~/.venvs/trufflehog/bin/activate && trufflehog filesystem .'
alias precheck='pre-commit run --all-files'
alias scan-secrets='thog'
alias scan-compliance='ck'

# === PowerShell ===
alias pshell='pwsh'
alias runps='pwsh -File'

# === VS Code ===
alias codep='code ~/Projects'
alias coder='code .'
alias codetf='code ~/Projects/terraform'
alias codeps='code ~/Projects/scripts/powershell'

# === System / CLI ===
alias reload='source ~/.bas

