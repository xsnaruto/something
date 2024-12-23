#!/bin/bash
echo "Start install neovim"
sleep 1s

# 安装最新 NeoVim
echo "Update & Install DEP"
sudo apt install software-properties-common -y >>/dev/null 2>&1
sudo add-apt-repository ppa:neovim-ppa/stable -y >>/dev/null 2>&1
sudo apt update >>/dev/null 2>&1
sudo apt install neovim -y >>/dev/null 2>&1
# sudo apt install fortunes -y >>/dev/null 2>&1
# sudo apt install cowsay -y >>/dev/null 2>&1
# sudo apt remove -y neovim >>/dev/null 2>&1
# sudo apt install -y snapd
# sudo snap install nvim --classic

# 更新 node.js 和 npm
echo "Dealing Node DEP"
sudo npm install -g n >>/dev/null 2>&1
n lts >>/dev/null 2>&1
sudo npm install -g prettier >>/dev/null 2>&1
sudo npm install -g @johnnymorganz/stylua-bin >>/dev/null 2>&1
sudo npm install -g cowsay >>/dev/null 2>&1
sudo npm install -g fortunes >>/dev/null 2>&1

# Clean may exist junk file
echo "Cleaning Old Neovim data"
rm -rf ~/.config/nvim >>/dev/null 2>&1
# rm -rf ~/.config/coc >>/dev/null 2>&1
# Create neovim config path
mkdir ~/.config/nvim -p >>/dev/null 2>&1
# mkdir ~/.config/nvim/plugged >>/dev/null 2>&1

# Install neovim plugin
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >>/dev/null 2>&1

# Neovim color install
# mkdir ~/.config/nvim/colors >>/dev/null 2>&1
# wget -O ~/.config/nvim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim >>/dev/null 2>&1

# Neovim config restore
echo "Getting Neovim Configuration"
wget -O ~/.config/nvim/init.lua https://github.com/xsnaruto/something/raw/main/config/nvim/init.lua >>/dev/null 2>&1

# Load PlugIns
echo "Finished, type <enter> continue"
read none
