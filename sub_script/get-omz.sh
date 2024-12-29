#!/bin/bash
echo "Install zsh and plugin"
sleep 1s

# Clean may exist junk file
rm -rf ~/.oh-my-zsh >>/dev/null 2>&1

# Install & Update zsh
sudo apt install zsh -y

# Install ohmyzsh
echo "y\n" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >>/dev/null 2>&1
# Set zsh as default shell
echo -e "/bin/zsh\n" | chsh >>/dev/null 2>&1

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >>/dev/null 2>&1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >>/dev/null 2>&1

sed -i "s#plugins=(git)#plugins=(\n\tgit\n\tzsh-autosuggestions\n\tzsh-syntax-highlighting\n)#g" ~/.zshrc >>/dev/null 2>&1

# Clean junk & Install  Starship
sh -c 'rm -rf "$(command -v 'starship')"' >>/dev/null 2>&1
sed -i "/# Starship/d" ~/.zshrc >>/dev/null 2>&1
sed -i "/eval \"\$(starship init zsh)\"/d" ~/.zshrc >>/dev/null 2>&1

curl -sS https://starship.rs/install.sh | sh
echo "" >>~/.zshrc
echo "# Starship" >>~/.zshrc
echo "eval \"\$(starship init zsh)\"" >>~/.zshrc

echo "finished, type <enter> continue"
read none
