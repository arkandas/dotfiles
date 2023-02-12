#!/bin/zsh

source ./menu.sh

#!/bin/zsh

source scripts/mac_setup.sh
source scripts/set_hostname.sh

# Config vars
pyenv_ver=3.11.1
rd="\033[1;31m"
msc="\033[1;36m"
hc="\033[1;31m"
hp="\033[38;2;44;252;3m"
bold='\033[1m'
endcolor="\033[0m" # End Color

menu() {
clear -x
echo -e "${bold}Dotfile Installer${endcolor}"
echo -e "${bold}----------------------------${endcolor}"
echo -e "1)  Configure new Mac"
echo -e "2)  Set hostname"
echo -e "3)  Set git credentials"
echo -e "4)  Exit"
echo -e "${bold}----------------------------${endcolor}"
echo -e ""
read "?Please select an option: " selection
   
case $selection in
        1)
            echo -e "${hp}Executing remote script${endcolor}"
            PYTHON_VERSION=${pyenv_ver} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/mac_setup12.sh)"
            sleep 2
            ;;
        2)
            echo -e "${hp}"
            read "?Chose a new hostname: " hostname
            NEWHOST=${hostname} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/set_hostname12.sh)"
            sleep 2
            menu
            ;;
        3)
            echo -e "${hp}"
            read "?Git user name: " gituser
            read "?Git user email: " useremail
            GITUSER=${gituser} USEREMAIL=${useremail} msc=${msc} endcolor=${endcolor} zsh -c "$(curl -fsSL https://raw.githubusercontent.com/arkandas/dotfiles/master/utils/git_config4.sh)"
            sleep 2
            menu
            ;;
        4)
            echo -e "Exiting.."
            exit
            ;;
        *)
            echo -e "${msc}\"$selection\"${rd} is not an option, try again${endcolor}"
            sleep 2
            menu
            ;;
    esac
    echo
}

menu