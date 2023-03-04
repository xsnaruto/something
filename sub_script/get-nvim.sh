#!/bin/bash
echo "Start install neovim"
sleep 1s

# 安装最新 NeoVim
apt install software-properties-common -y >>/dev/null 2>&1
add-apt-repository ppa:neovim-ppa/stable -y >>/dev/null 2>&1
apt update && apt install neovim -y >>/dev/null 2>&1

# Clean may exist junk file
rm -rf ~/.config/nvim >>/dev/null 2>&1
# Create neovim config path
mkdir ~/.config/nvim -p >>/dev/null 2>&1
mkdir ~/.config/nvim/plugged >>/dev/null 2>&1

# Install neovim plugin
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >>/dev/null 2>&1

# Neovim color install
mkdir ~/.config/nvim/colors >>/dev/null 2>&1
wget -O ~/.config/nvim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim >>/dev/null 2>&1

# Neovim config restore
wget -O ~/.config/nvim/init.vim https://github.com/xsnaruto/something/raw/main/config/init.vim >>/dev/null 2>&1

# Load PlugIns
echo "finished, type <enter> continue"
read none
