. /etc/os-release

echo "Installing LSPs.."
case $ID in
  ubuntu)
	sudo apt update && sudo apt install -y clangd; sudo apt install -y lua-language-server; sudo apt install -y python3-pylsp
    ;;

  arch) 
	yes | sudo pacman -Syu && yes | sudo pacman -S bear clang lua-language-server python-lsp-server
    ;;

  *) echo "Your distribution is not supported :("
      ;;
esac

