#! /bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

source $DOTFILES_DIR/nvim/install-lsp.sh

rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim/
cp -r ./nvim/* ~/.config/nvim/
