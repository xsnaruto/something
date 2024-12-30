#!/bin/bash
echo "Install zsh and plugin"
sleep 1s

# Install/Reinstall Starship
sh -c 'rm -rf "$(command -v 'starship')"' >>/dev/null 2>&1
curl -sS https://starship.rs/install.sh | sh

# Install/Update zsh
sudo apt install zsh -y
# Set zsh as default shell
echo -e "/bin/zsh\n" | chsh >>/dev/null 2>&1

# Clean old config data
rm ~/.zshrc >>/dev/null 2>&1
rm -rf ~/.oh-my-zsh >>/dev/null 2>&1

# Install zimfw
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh >>/dev/null 2>&1

rm ~/.zimrc >>/dev/null 2>&1
rm -rf ~/.zim >>/dev/null 2>&1

# Restore zim config
wget -O .zimrc https://raw.githubusercontent.com/xsnaruto/something/refs/heads/main/config/zimfw/.zimrc >>/dev/null 2>&1

# ZIM compinit check for Ubuntu
# 检查系统是否为 Ubuntu
if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
    # 定义 zshenv 文件路径
    ZSHENV_FILE="$HOME/.zshenv"

    # 检查 zshenv 文件是否存在
    if [[ -f "$ZSHENV_FILE" ]]; then
        # 检查文件中是否已包含 skip_global_compinit=1
        if ! grep -q "^skip_global_compinit=1" "$ZSHENV_FILE"; then
            # 在文件首行添加 skip_global_compinit=1
            sed -i '1i skip_global_compinit=1' "$ZSHENV_FILE"
            echo "已在 $ZSHENV_FILE 首行添加 skip_global_compinit=1。"
        else
            echo "$ZSHENV_FILE 已包含 skip_global_compinit=1，无需修改。"
        fi
    else
        # 创建 zshenv 文件并添加 skip_global_compinit=1
        echo "skip_global_compinit=1" > "$ZSHENV_FILE"
        echo "已创建 $ZSHENV_FILE 并添加 skip_global_compinit=1。"
    fi
else
    echo "此脚本仅适用于 Ubuntu 系统。"
fi

echo "finished, type <enter> continue"
read none
