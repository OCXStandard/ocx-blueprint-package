# A self-documenting Makefile
# You can set these variables from the command line, and also
# from the environment for the first two.

SOURCEDIR = ./{{cookiecutter.package_slug}}

# Color output
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# PROJECT SETUP ##############################################################
install-tools: ## Install the uv toolbox
	@uv tool install ruff
	@uv tool install tbump
	@iv tool install pre-commit

it: install-tools

init: ## Initiate the project using uv. Install all dependencies in the virtual environment and activate it
	@uv sync

ps-venv:  ## Activate the virtual environment for powershell terminal
	@powershell -NoProfile -ExecutionPolicy Bypass -Command "& { . .venv/Scripts/activate.ps1 }"
	@powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Activated virtual environment' -ForegroundColor Blue"
av: ps-venv


# DOCUMENTATION ##############################################################
doc-build: ## Build the html docs using Sphinx. For other Sphinx options, run make in the docs folder
	@uv run sphinx-build docs _build

doc-links: ## Check the internal and external links after building the documentation
	@uv run sphinx-build docs -W -b linkcheck -d _build/doctrees _build/html
PHONY: doc-links

doc-export: ## Export the requirements to docs/requirements.txt
	@uv export --no-hashes --group docs -o docs/requirements.txt

# pre-commit ######################################################################
pre-commit:	## Run the pre-commit hooks
	@uv run pre-commit run --all-files

# TESTS #######################################################################
test:  ## Run unit and integration tests
	@uv run pytest --log-disable=test --durations=5  --cov-report html --cov=$(SOURCEDIR)

test-upd:  ## Run unit and integration tests and force update baselines
	@uv run pytest --force-regen --durations=5  --cov-report html --cov=$(SOURCEDIR)


test-cov:  ## View the test coverage report
	cmd /c start $(CURDIR)/htmlcov/index.html


.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

#-----------------------------------------------------------------------------------------------
