#! /bin/bash

source ~/dotfiles/nvim/install-lsp-bash.sh

rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim/
cp -r ~/dotfiles/nvim/* ~/.config/nvim/
