#!/bin/bash
set -e
echo "🚀 Starting DevSecOps Bootstrap Setup..."
./scripts/bootstrap-tools.sh
./scripts/bootstrap-venvs.sh
./scripts/bootstrap-posh-theme.sh
./scripts/bootstrap-link-projects.sh
./scripts/bootstrap-aliases.sh
./scripts/bootstrap-profile-hooks.sh
echo "✅ Setup complete. Run: source ~/.bashrc"
