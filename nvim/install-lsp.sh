. /etc/os-release

echo "Installing LSPs.."

TARGET_LINK="$HOME/.local/bin/lua-language-server"

case $ID in
  ubuntu)
	sudo apt update && sudo apt install -y clangd; sudo apt install -y python3-pylsp
    	if [ ! -e "$TARGET_LINK" ]; then
            wget https://sourceforge.net/projects/lua-language-server.mirror/files/3.17.1/lua-language-server-3.17.1-linux-x64.tar.gz/download -O lua-language-server-3.17.1-linux-x64.tar.gz
            mkdir -p ~/.local/share/lua-lang-server && \
            tar --extract --file lua-language-server-3.17.1-linux-x64.tar.gz -av -C ~/.local/share/lua-lang-server && \
            ln -s ~/.local/share/lua-lang-server/bin/lua-language-server "$TARGET_LINK" && \
            rm ./lua-language-server-3.17.1-linux-x64.tar.gz
        else
            echo "skip: lua-language-server already exists"
fi
    ;;

  arch) 
	yes | sudo pacman -Syu && yes | sudo pacman -S bear clang lua-language-server python-lsp-server
    ;;

  *) echo "Your distribution is not supported :("
      ;;
esac

