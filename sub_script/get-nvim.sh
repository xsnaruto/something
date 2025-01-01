#!/bin/bash
echo "Start install neovim"
sleep 1s

# 安装最新 NeoVim
echo "Update & Install DEP"
sudo apt install software-properties-common -y >>/dev/null 2>&1
sudo add-apt-repository ppa:neovim-ppa/stable -y >>/dev/null 2>&1
sudo apt update >>/dev/null 2>&1
sudo apt install neovim -y >>/dev/null 2>&1
sudo apt install fortunes -y >>/dev/null 2>&1
sudo apt install cowsay -y >>/dev/null 2>&1

# 检测当前使用的 Shell
if [[ $SHELL == *"bash"* ]]; then
  CONFIG_FILE=~/.bashrc
elif [[ $SHELL == *"zsh"* ]]; then
  CONFIG_FILE=~/.zshrc
else
  echo "未检测到 bash 或 zsh，请手动确认您的 Shell 类型。"
  exit 1
fi

# 检查配置文件中是否已包含路径
if ! grep -qE '(/usr/games|/usr/local/games)' "$CONFIG_FILE"; then
  echo "export PATH=\"\$PATH:/usr/games:/usr/local/games\"" >> "$CONFIG_FILE"
  echo "已将 /usr/games 和 /usr/local/games 永久添加到 $CONFIG_FILE 中。请运行 'source $CONFIG_FILE' 或重新登录以生效。"
else
  echo "/usr/games 和 /usr/local/games 已经存在于 $CONFIG_FILE 中，无需重复添加。"
fi

# sudo apt remove -y neovim >>/dev/null 2>&1
# sudo apt install -y snapd
# sudo snap install nvim --classic

# 更新 node.js 和 npm
echo "Dealing Node DEP"
sudo npm install -g n >>/dev/null 2>&1
n lts >>/dev/null 2>&1
sudo npm install -g prettier >>/dev/null 2>&1
sudo npm install -g @johnnymorganz/stylua-bin >>/dev/null 2>&1
# sudo npm install -g cowsay >>/dev/null 2>&1
# sudo npm install -g fortunes >>/dev/null 2>&1

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
wget -O ~/.wakatime.cfg https://gist.githubusercontent.com/xsnaruto/946c05aaef51ea5f62b00d17af80103e/raw/617c56ff1b4d95734508f638ead92dbeaabb042a/.wakatime.cfg >>/dev/null 2>&1

# Load PlugIns
echo "Finished, type <enter> continue"
read none
