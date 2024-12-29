#!/bin/bash
echo "Install zsh and plugin"
sleep 1s

# Install/Reinstall Starship
sh -c 'rm -rf "$(command -v 'starship')"' >>/dev/null 2>&1
curl -sS https://starship.rs/install.sh | sh

# Clean may exist junk file
rm ~/.zshrc >>/dev/null 2>&1
rm ~/.zimrc >>/dev/null 2>&1
rm -rf ~/.oh-my-zsh >>/dev/null 2>&1
rm -rf ~/.zim >>/dev/null 2>&1

# Install/Update zsh
sudo apt install zsh -y
# Set zsh as default shell
echo -e "/bin/zsh\n" | chsh >>/dev/null 2>&1

# Install zimfw
# echo "y\n" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >>/dev/null 2>&1
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh >>/dev/null 2>&1

# Install zimfw
wget -o .zimrc https://raw.githubusercontent.com/xsnaruto/something/refs/heads/main/config/zimfw/.zimrc >>/dev/null 2>&1

echo "finished, type <enter> continue"
read none
