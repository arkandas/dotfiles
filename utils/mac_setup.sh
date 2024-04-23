#!/bin/zsh

# Check if the dotfiles directory exists
if [ -d "dotfiles" ];
then
    echo "dotfiles directory exists. Exiting"
    exit 1
else

# Install XCode Command Line Tools
echo -e "${msc}Install XCode Command Line Tools${endcolor}"
xcode-select --install &> /dev/null

# Wait until XCode Command Line Tools installation has finished
until $(xcode-select --print-path &> /dev/null); do
  sleep 5;
done

# Close any open System Preferences panes,
# to prevent them from overriding settings we're about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
echo -e "${msc}Administrator password${endcolor}"
sudo -v

# Keep-alive: update existing `sudo` time stamp until mac_setup has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Clone dotfiles project
echo -e "${msc}Clone dotfiles project${endcolor}"
git clone https://github.com/arkandas/dotfiles.git

# Install Homebrew (https://brew.sh)
echo  -e "${msc}Install Homebrew${endcolor}"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make shell find brew
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install formulae, casks and apps from Brewfile
echo  -e "${msc}Restore Brewfile${endcolor}"
brew bundle --file dotfiles/mac_os/brew/Brewfile

# Accept Xcode license
echo  -e "${msc}Accept Xcode license${endcolor}"
sudo xcodebuild -license accept

# Oh-my-zsh and plugins
echo -e "${msc}Install oh-my-zsh${endcolor}"
touch ~/.hushlogin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh Plugins
echo -e "${msc}Install Zsh Plugins${endcolor}"

# zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
echo -e "${msc}Install zsh-autosuggestions${endcolor}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
echo -e "${msc}Install zsh-syntax-highlighting${endcolor}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-completions (https://github.com/zsh-users/zsh-completions)
echo -e "${msc}Install zsh-completions${endcolor}"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# Powerlevel10k Zsh theme (https://github.com/romkatv/powerlevel10k)
echo -e "${msc}Install powerlevel10k${endcolor}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Iterm2 and Zsh configurations
echo -e "${msc}Iterm2 and Zsh configurations${endcolor}"

# Iterm2 settings
cp dotfiles/mac_os/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
# powerlevel10k settings
cp dotfiles/mac_os/zsh/.p10k.zsh ~/.p10k.zsh
# .zshrc
cp dotfiles/mac_os/zsh/.zshrc ~/.zshrc

# Edit /etc/shells and append the zsh homebrew shell
echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells
sudo chsh -s $(which zsh)
source ~/.zshrc

# Global .gitignore
echo -e "${msc}Copy global gitignore${endcolor}"
cp dotfiles/mac_os/git/.gitignore ~/.gitignore

# Simlink OpenJDK for the system Java wrappers to find it
echo -e "${msc}Fix OpenJDK Linking${endcolor}"
sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Install python through pyenv
echo -e "${msc}Install and configure python${endcolor}"
pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
pip3 install --upgrade pip

# Install node lts
echo -e "${msc}Install and configure node${endcolor}"
fnm install --lts
fnm use lts/latest
fnm current

# Install Angular and update npm
echo -e "${msc}Install and configure angular${endcolor}"
npm install -g @angular/cli
# Update npm
npm install -g npm

# Add Angular completions to .zshrc
echo >> ~/.zshrc
echo "# Load Angular CLI autocompletion." >> ~/.zshrc
echo "source <(ng completion script)" >> ~/.zshrc
source ~/.zshrc

# Add nano configuration
echo -e "${msc}Copy nano configuration${endcolor}"
cp dotfiles/mac_os/nano/.nanorc ~/.nanorc

# Remove dotfiles project
echo -e "${msc}Cleanup${endcolor}"
rm -rf dotfiles

fi
