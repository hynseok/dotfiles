#!/bin/bash
# thanks larsks, https://stackoverflow.com/questions/75146772/how-to-detect-os-system-using-bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

. /etc/os-release

case $ID in
  ubuntu) echo "Detected distribution : Ubuntu"
	echo "Installing Dependencies.."
	sudo apt update
	echo "this dotfiles need nvim version newer than 0.11 but with apt you can't get it."
	echo "Try install it by yourself."
	#sudo apt update && sudo apt install -y neovim
	sudo apt install -y tmux
	source $DOTFILES_DIR/nvim/install.sh
	source $DOTFILES_DIR/tmux/install.sh
    ;;

  arch) echo "Detected distribution : Arch"
	echo "Installing Dependencies.."
	yes | sudo pacman -Syu && yes | sudo pacman -S nvim tmux
	source $DOTFILES_DIR/nvim/install.sh
	source $DOTFILES_DIR/tmux/install.sh
    ;;

  *) echo "Your distribution is not supported :("
      ;;
esac
