all: tools venvs aliases posh

tools:
	./scripts/bootstrap-tools.sh

venvs:
	./scripts/bootstrap-venvs.sh

aliases:
	./scripts/bootstrap-aliases.sh

posh:
	./scripts/bootstrap-posh-theme.sh
