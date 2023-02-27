#!/bin/zsh

# Set computer name (as done via System Preferences → Sharing)
echo -e "${msc}Setting computer name as: ${NEWHOST} ${endcolor}"
sudo scutil --set ComputerName ${NEWHOST}
sudo scutil --set HostName ${NEWHOST}
sudo scutil --set LocalHostName ${NEWHOST}
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string ${NEWHOST}
echo -e "${msc}Done${endcolor}"