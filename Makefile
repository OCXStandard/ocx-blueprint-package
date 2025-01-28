# Blueprint Makefile
# A self-documenting Makefile
# You can set these variables from the command line, and also
# from the environment for the first two.

CONDA_ENV = ocx-blueprint-package
CONDA_YAML = environment.yaml
# PS replacements for sh
RM = 'del -Confirmed False'

# CONDA TASKS ##################################################################
# PROJECT setup using conda and powershell
.PHONY: conda-create
conda-create:  ## Create a new conda environment with the python version and basic development tools
	@conda env create -f $(CONDA_YAML)
	@conda activate $(CONDA_ENV)
cc: conda-create
.PHONY: cc
conda-upd: environment.yaml## Update the conda development environment when environment.yaml has changed
	@conda env update -f $(CONDA_YAML)
cu: conda-upd
.PHONY:cu


conda-activate: ## Activate the conda environment for the project
	@conda activate $(CONDA_ENV)
ca: conda-activate
.PHONY: ca

conda-clean: ## Purge all conda tarballs, log files and caches
	conda clean -a -y
.Phony: conda-clean


# Color output
BLUE='\033[0;34m'
NC='\033[0m' # No Color


BAKE_OPTIONS=--no-input

bake:  ## Generate project using defaults
	cookiecutter $(BAKE_OPTIONS) . --overwrite-if-exists

watch: bake ## Generate project using defaults and watch for changes
	watchmedo shell-command -p '*.*' -c 'make bake -e BAKE_OPTIONS=$(BAKE_OPTIONS)' -W -R -D \{{cookiecutter.project_slug}}/

replay: BAKE_OPTIONS=--replay ## Replay last cookiecutter run and watch for changes
replay: watch
	;

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help