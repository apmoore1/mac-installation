# Mac software installation

Installs:

1. Conda through [miniconda](https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent)

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

## Installation script in detail

This instllation script:

1. Downloads the latest [miniconda](https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent) and installs it to `~/miniconda` without intervention (`-b`) and runs the tests to ensure it is built correctly (`-t`)
2. Line 7, `conda init zsh` is currently setup for MacOS Catalina and greater as Mac moved to the `zsh` shell. If you are using an older version of MacOS change this line to `conda init`

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

