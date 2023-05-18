#!/bin/zsh

echo -e "${msc}Setting git credentials:"
echo -e "User name: ${GITUSER}"
echo -e "User email: ${GITEMAIL}${endcolor}"
git config --global user.name "${GITUSER}"
git config --global user.email "${GITEMAIL}"
ssh-add --apple-use-keychain ~/.ssh/id_rsa
touch ~/.gitignore
git config --global core.excludesfile ~/.gitignore
# Use diff-so-fancy for all diff output
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
# Improved diff colors
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
echo -e "${msc}Done${endcolor}"
