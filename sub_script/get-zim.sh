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

echo "finished, type <enter> continue"
read none
