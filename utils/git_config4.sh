#!/bin/zsh

echo -e "${msc}Setting git credentials:"
echo -e "User name: ${GITUSER}"
echo -e "User email: ${USEREMAIL}${endcolor}"
git config --global user.name "${GITUSER}"
git config --global user.email "${USEREMAIL}"
ssh-add --apple-use-keychain ~/.ssh/id_rsa
touch ~/.gitignore
git config --global core.excludesfile ~/.gitignore
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
echo -e "${msc}Done${endcolor}"