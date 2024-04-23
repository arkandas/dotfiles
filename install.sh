#!/bin/zsh

# ===========================
#   Dotfile Installer 2023
# ===========================

# Config vars
pyenv_ver=3.11.1
rd="\033[1;31m"
msc="\033[1;36m"
hc="\033[1;31m"
hp="\033[1;32m"
bold='\033[1m'
endcolor="\033[0m"

menu() {
clear -x
echo -e "${bold}Dotfile Installer${endcolor}"
echo -e "${bold}----------------------------${endcolor}"
echo -e "1)  Configure new Mac"
echo -e "2)  Restore system preferences"
echo -e "3)  Set computer name"
echo -e "4)  Set git credentials"
echo -e "5)  Exit"
echo -e "${bold}----------------------------${endcolor}"
echo -e ""
read "?Please select an option: " selection

case $selection in
        1)
            echo -e "${hp}Executing remote script - Configure new Mac${endcolor}"
            PYTHON_VERSION=${pyenv_ver} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/mac_setup.sh)"
            sleep 2
            menu
            ;;
        2)
            echo -e "${hp}Executing remote script - Restore system preferences${endcolor}"
            PYTHON_VERSION=${pyenv_ver} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/system_prefs.sh)"
            sleep 2
            menu
            ;;
        3)
            echo -e "${hp}"
            read "?Chose a new hostname: " hostname
            NEWHOST=${hostname} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/set_hostname.sh)"
            sleep 2
            menu
            ;;
        4)
            echo -e "${hp}"
            read "?Git username: " gituser
            read "?Git email address: " gitemail
            GITUSER=${gituser} GITEMAIL=${gitemail} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/git_config.sh)"
            sleep 2
            menu
            ;;
        5)
            echo -e "Exiting..."
            exit
            ;;
        *)
            echo -e "${msc}$selection${rd} is not an option, try again${endcolor}"
            sleep 2
            menu
            ;;
    esac
    echo
}

menu
