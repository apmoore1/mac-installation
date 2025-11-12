# Mac software installation

**Note** All of the following also works for the new M1 Apple processors.

**Note** If you want to install Python so that it works with the new M1 GPUs follow these instructions: https://llama-cpp-python.readthedocs.io/en/latest/install/macos/

Installs:

1. Command line tools for Mac e.g. `git`, this needs to be installed first 
2. Conda through [miniconda](https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent)
3. Setting the main editor for `git` as nano.

For the command line tools run, this was taken from this [apple stackexchange post](https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a) which describes other solutions for command line tools for Mac:

``` bash
xcode-select --install
```

For more detail on the installation script see section [Installation script in detail.](#installation-script-in-detail)


To install this software on the Mac run:
``` bash
bash install.sh
```

## Table of contents

1. [Installation script in detail](#installation-script-in-detail)
2. [conda](#conda)
    1. [Updating](#updating)
    2. [Deleting](#deleting)
    3. [Guide](#guide)
3. [Docker desktop](#docker-desktop) - this is not installed in the script
4. [Brew for GPG](#brew-for-gpg) - installed through the [./brew_install.sh script](./brew_install.sh)

## Installation script in detail

This instllation script:

1. Downloads the latest [miniconda](https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent) and installs it to `~/miniconda` without intervention (`-b`) and runs the tests to ensure it is built correctly (`-t`)
2. Line 7, `conda init zsh` is currently setup for MacOS Catalina and greater as Mac moved to the `zsh` shell. If you are using an older version of MacOS change this line to `conda init`
3. Setting the main editor for `git` as nano, line 11.

## conda

### Updating

Run the following:
``` bash
conda update conda
```

### Deleting 

1. Remove conda from where you installed in, the `install.sh` script in this repository install it to `~/miniconda` thus:
``` bash
rm -rf ~/miniconda
```
2. Remove the conda path from `~/.zshrc` if you are on MacOS Catalina or greater else remove from `~/.bash_profile`
3. Remove any of the conda hidden files `rm -rf ~/.condarc ~/.conda ~/.continuum`

### Guide

For a quick guide to conda see this [page](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html) and a cheat sheet to conda commands [here.](https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html)

If you do not want your command line to have a `(base)` at the begging of the prompt run `conda deactivate`. What `(base)` means is that the base conda environment is currently activate hence the reason why when you run `which python` it comes up as `$HOME/miniconda/bin/python` when `(base)` is active else it will return `/usr/bin/python`. If you want to use the `base` conda environment run `conda activate`.

If you do not want the `(base)` conda environment to run each time you start up a new command terminal, run the following and start a new terminal:
``` bash
conda config --set auto_activate_base false
```

## Docker desktop

This can be installed from [Docker](https://docs.docker.com/docker-for-mac/install/) as an application, it takes up around 5GB, and includes Docker Engine, Docker CLI client, Docker Compose, Notary, Kubernetes, and Credential Helper.

### Unistall

See the following [docker help page.](https://docs.docker.com/docker-for-mac/install/#uninstall-docker-desktop)

## Brew for GPG

GPG is used by [GitHub to sign commits](https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/about-commit-signature-verification), the best way I have found to install this on the Mac is through [Brew](https://brew.sh/). Brew can be installed using the [./brew_install.sh script.](./brew_install.sh):

```
bash brew_install.sh
```

This script will ask for your password, as it installs brew to the following directory `/opt/homebrew` if on Apple Silcon CPU else it will be `/usr/local`. Once you have run this script you will need to add brew to the `$PATH` environment variable, do this be adding the following to `~/.zshrc`:

``` bash
export PATH=/opt/homebrew/bin:$PATH # if brew was installed to /usr/local then use the line below instead
# export PATH=/usr/local/bin:$PATH
```

This part of the guide was based off the [digital ocean guide on how to install and uninstall brew.](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-macos)

To install gpg:

```
brew install gnupg
```

**Note** I did try to install this through conda, but conda does not have pinentry which is required, therefore we cannot use conda and have to install brew to use gpg.

### Uninstall Brew

Read the [uninstall instructions from brew](https://github.com/Homebrew/install#uninstall-homebrew), which should uninstall brew and all of it's packages e.g. gpg.

## UV for python

See the following for [installtion details](https://docs.astral.sh/uv/getting-started/installation/).

``` bash
curl -Lfo uv_install.sh https://astral.sh/uv/install.sh
sh uv_install.sh

echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bash_profile
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bash_profile
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc
```

### HuggingFace Hub

To install the HuggingFace hub python library for the user, installs to the bin $PATH of UV ([guide from HuggingFace](https://huggingface.co/docs/huggingface_hub/en/guides/cli#using-uv)):

``` bash
uv tool install "huggingface_hub"
```

and now the `hf` command can be used, like so:

``` bash
hf --help
```

To login:

``` bash
hf auth login --token $HF_TOKEN --add-to-git-credential
```

To logout:

``` bash
hf auth logout
```
This command logs you out. In practice, it will delete all tokens stored on your machine. If you want to remove a specific token, you can specify the token name as an argument. This command will not log you out if you are logged in using the HF_TOKEN environment variable (see reference). If that is the case, you must unset the environment variable in your machine configuration (`unset HF_TOKEN`).

For more information of `hf auth` see the [following](https://huggingface.co/docs/huggingface_hub/en/guides/cli#command-line-interface-cli).

uv also has authentication support for HuggingFace, see the [following](https://docs.astral.sh/uv/concepts/authentication/third-party/#hugging-face-support).

## Git LFS and xet

This has come from the HuggingFace [guide.](https://huggingface.co/docs/hub/xet/using-xet-storage#git)

We assume that `$HOME/.local/bin` is a path on the $PATH environment variable.

``` bash
brew install git-lfs
git lfs install
curl --proto '=https' --output xet_install.sh --tlsv1.2 -sSf https://raw.githubusercontent.com/huggingface/xet-core/refs/heads/main/git_xet/install.sh
# Change the INSTALL_DIR to INSTALL_DIR="/Users/andrew/.local/bin"
cat xet_install.sh| sh
rm xet_install.sh
# TEST: git-xet --version
```

To uninstall:

``` bash
git-xet uninstall
sudo rm $(which git-xet)
```

