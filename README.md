# ocx-blueprint-package
## Version: 1.0.0
### A cookiecutter template for easily setting up a development environment for an OCX Python package

The cookiecutter blueprint will create  a Python project for a distributable python module.
The blueprint installs support for:
 - .venv environment
 - uv for package dependency management
 - github hooks and workflows for CI
 - Makefile for development support

The blueprint will install development tools and the common ocx packages.

## Pre-requisites
To use the blueprint, the following has to be installed on your system:
 - A python version
 - [uv package manager](https://github.com/astral-sh/uv) from astral
 - [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/)

### uv
uv is an extremely fast Python package and project manager, written in Rust.

[Highlights](https://github.com/astral-sh/uv?tab=readme-ov-file#highlights)

#### [Installation](https://github.com/astral-sh/uv?tab=readme-ov-file#installation)

Installation on Windows:
````commandline
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
````
### cookiecutter
install cookiecutter from uv:
````commandline
uv add cookiecutter
````

## To create a new project
Run cookiecutter from a terminal and answer the interactive prompts.

````commandline
cookiecutter git@github.com:OCXStandard/ocx-blueprint-package.git
````

## Usage
After setting up the development environment, the following command will install all the tools and the package dependencies. Run the commands from a terminal window in the root folder of your project.
````commandline
make install-tools
make init
````

### Installed tools
The blueprint will install the following development tools
- [tbump](https://github.com/your-tools/tbump) for package version management
- [pre-commit](https://pre-commit.com/) hooks: check-yaml, end-of-file-fixer, trailing-whitespace, ruff and pytest for local repo tests 


## Makefile
The Makefile utility has support for the following Make commands:

```
doc-links                      Check the internal and external links after building the documentation
doc-serve                      Open the the html docs built by Sphinx
doc-build                      Build the html docs using Sphinx. For other Sphinx options, run make in the docs folder
doc-export                     Export the requirements to docs/requirements.txt
help                           Show this help
init                           Initiate the project using uv. Install all dependencies in the virtual environment and activate it
install-tools                  Install the uv toolbox
pre-commit                     Run the pre-commit hooks
ps-venv                        Activate the virtual environment for a powershell terminal
test-cov                       View the test coverage report
test-upd                       Run unit and integration tests
test                           Run unit and integration tests
```

## Development on Windows

Windows does not support a Makefile out of the box. This is a recipe for setting up Python and Makefile support on 
a Windows machine using [Conda Miniforge](https://github.com/conda-forge/miniforge)

### Installer

Download the [Installer](hhttps://github.com/conda-forge/miniforge#requirements-and-installers) (all systems) from here. 

### Installation
After download of the Windows installer, execute the installer and follow the instructions.

For non-interactive usage one can use the batch install option:
`````commandline
start /wait "" Miniforge3-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%UserProfile%\Miniforge3
`````
The installer will install the conda/mamba commands and the latest Python version in the **base** encironment.

### Setting up the development environment

The following ``environment.yaml`` file will set up a development environment once you have installed Miniforge


```yaml
# Minimal conda environment with python, pip and poetry and windows Make file support.
# Dependencies are managed by Poetry
name: dev
channels:
  - conda-forge
  - msys2 # for m2-grep
  # We want to have a reproducible setup, so we don't want default channels,
  # which may be different for different users. All required channels should
  # be listed explicitly here.
  - nodefaults
dependencies:
  - m2w64-make # GNU Make for windows
  - m2-grep # Grep for windows. For Makefile sh
  - m2-gawk # awk for windows. for Makefile sh
  - cookiecutter
```
Save the file in the root folder of your project and run the following command from a terminal window:
```
conda env -f environment.yaml