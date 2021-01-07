#!/bin/bash

# Conda
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o ~/miniconda.sh
bash ~/miniconda.sh -b -p ~/miniconda -t
source ~/miniconda/bin/activate
conda init zsh
rm ~/miniconda.sh