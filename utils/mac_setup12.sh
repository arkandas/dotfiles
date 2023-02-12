#!/bin/zsh

if [ -d "dotfiles" ];
then
    echo "dotfiles directory exists. Exiting"
    exit 1
else
echo -e "${msc}Install XCode Command Line Tools.${endcolor}"
# Install XCode Command Line Tools.
xcode-select --install &> /dev/null
# Wait until XCode Command Line Tools installation has finished.
until $(xcode-select --print-path &> /dev/null); do
  sleep 5;
done
# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit'
# Ask for the administrator password upfront
echo -e "${msc}Administrator password${endcolor}"
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo -e "${msc}Clone dotfiles project${endcolor}" 

git clone https://github.com/arkandas/dotfiles.git

echo  -e "${msc}Install Homebrew${endcolor}" 

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo  -e "${msc}Restore Brewfile${endcolor}" 
brew bundle --file dotfiles/mac_os/brew/Brewfile

echo  -e "${msc}Accept xcode license${endcolor}" 
sudo xcodebuild -license accept

echo -e "${msc}Restore System Settings${endcolor}"

/bin/bash dotfiles/mac_os/os_settings/os_prefs.sh

echo -e "${msc}Configure iterm and zsh${endcolor}"

echo -e "${msc}Install oh-my-zsh${endcolor}"
touch ~/.hushlogin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e "${msc}Install Zsh Plugins${endcolor}"

echo -e "${msc}Install zsh-autosuggestions${endcolor}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "${msc}Install zsh-syntax-highlighting${endcolor}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "${msc}Install zsh-completions${endcolor}"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo -e "${msc}Install powerlevel10k${endcolor}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "${msc}Copy iterm and zsh configuration${endcolor}"
cp dotfiles/mac_os/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
cp dotfiles/mac_os/zsh/.p10k.zsh ~/.p10k.zsh
cp dotfiles/mac_os/zsh/.zshrc ~/.zshrc

# Edit /etc/shells and append the zsh homebrew shell
echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells
sudo chsh -s $(which zsh)
source ~/.zshrc

echo -e "${msc}Fix OpenJDK Linking${endcolor}"
sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

echo -e "${msc}Install and configure python${endcolor}"
pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
pip3 install --upgrade pip

echo -e "${msc}Install and configure node${endcolor}"
fnm install --lts
fnm use lts/latest
fnm current

echo -e "${msc}Install and configure angular${endcolor}"
npm install -g @angular/cli
# Update npm
npm install -g npm
# Add completions to .zshrc
echo "" >> ~/.zshrc
echo "# Load Angular CLI autocompletion." >> ~/.zshrc
echo "source <(ng completion script)" >> ~/.zshrc
source ~/.zshrc

echo -e "${msc}Copy nano configuration${endcolor}"
cp dotfiles/mac_os/nano/.nanorc ~/.nanorc

echo -e "${msc}Copy global gitignore${endcolor}"
cp dotfiles/mac_os/git/.gitignore ~/.gitignore

echo -e "${msc}Cleanup${endcolor}"
rm -rf dotfiles

fi