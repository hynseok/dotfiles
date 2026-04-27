#!/bin/bash
# thanks larsks, https://stackoverflow.com/questions/75146772/how-to-detect-os-system-using-bash

# set -e

DOTFILES_DIR="$HOME/dotfiles"
CURRENT_SHELL=$(basename "$SHELL")

echo "Installing NeoVim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm ./nvim-linux-x86_64.tar.gz

if [ "$CURRENT_SHELL" = "zsh" ]; then
    TARGET_FILE="$HOME/.zshrc"
elif [ "$CURRENT_SHELL" = "bash" ]; then
    TARGET_FILE="$HOME/.bashrc"
else
    echo "Your shell is not supported: $CURRENT_SHELL"
    exit 1
fi

read -r -d '' CONTENT << 'EOF'
# from dotfiles
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias vi='nvim'
alias vim='nvim'
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
EOF

echo "$CONTENT" | while IFS= read -r line || [ -n "$line" ]; do
    if ! grep -Fxq "$line" "$TARGET_FILE"; then
        echo "$line" >> "$TARGET_FILE"
        echo "Added: $line"
    else
        echo "Skipped (already exists): $line"
    fi
done

echo "Configuration update complete for $TARGET_FILE"

source $TARGET_FILE

echo "Installing metals"
curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
chmod +x cs
sudo mv cs /usr/local/bin/
cs setup
cs install metals

. /etc/os-release

case $ID in
  ubuntu) echo "Detected distribution : Ubuntu"
	echo "Installing Tmux.."
	sudo apt update
	sudo apt install -y tmux
    ;;

  arch) echo "Detected distribution : Arch"
	echo "Installing Tmux.."
	yes | sudo pacman -Syu && yes | sudo pacman -S tmux
    ;;

  *) echo "Your distribution is not supported :("
     exit 1  
    ;;
esac

source $DOTFILES_DIR/nvim/install.sh
source $DOTFILES_DIR/tmux/install.sh

