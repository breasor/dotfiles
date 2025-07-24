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
alias reload='source ~/.bashrc'
alias aliases='code ~/.bash_aliases'
alias hist='history | tail -n 50'
alias md='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# === Process & Network ===
alias top5='ps aux --sort=-%mem | head -n 6'
alias ports='ss -tuln'

# === Time ===
alias today='date +"%Y-%m-%d"'
alias now='date +"%Y-%m-%d %H:%M:%S"'

# === AWS ===
alias whoami='aws sts get-caller-identity'
alias awsp='aws configure list-profiles'

# === Smart ls with icon fallback ===
if command -v lsd >/dev/null 2>&1; then
    alias ls="lsd --group-dirs=first --icon=auto"
    alias l="lsd -lah --group-dirs=first --icon=always"
    alias ll="lsd -l --group-dirs=first --icon=auto"
    alias lt="lsd --tree --depth=2 --icon=always"
else
    alias ls="ls --color=auto"
    alias l="ls -lah --color=auto"
    alias ll="ls -l --color=auto"
    al

