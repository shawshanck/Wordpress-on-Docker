#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

installApps()
{
    clear
    OS="$REPLY" ## <-- This $REPLY is about OS Selection
    echo -e "${NC}You can Install ${GREEN}Wordpress, MYSQL and Adminer${NC} with this script!${NC}"
    echo -e "Please select ${GREEN}'y'${NC} for each item you would like to install."
    echo -e "${RED}NOTE:${NC} Without Docker and Docker-Compose, you cannot install this container.${NC}"
    echo -e ""
    echo -e "To install Docker and Docker-Compose, use the link below:"
    echo -e "${GREEN}https://github.com/shawshanck/Docker-and-Docker-Compose${NC}"
     echo -e ""
    echo -e "      ${CYAN}Provided to you by ${YELLOW}Mohammad Mohammadpour${NC}"
    echo -e "          ${YELLOW}https://github.com/shawshanck${NC}"
    echo -e ""
    
    ISACT=$( (sudo systemctl is-active docker ) 2>&1 )
    ISCOMP=$( (docker-compose -v ) 2>&1 )

    #### Try to check whether docker is installed and running - don't prompt if it is
    
    read -rp "Wordpress, MYSQL and Adminer (y/n): " WMA

    startInstall
}

startInstall() 
{
    clear
    echo "#######################################################"
    echo "###         Preparing for Installation              ###"
    echo "#######################################################"
    echo ""
    sleep 3s


    if [[ "$WMA" == [yY] ]]; then
        echo "#################################################"
        echo "###    Install Wordpress, MYSQL and Adminer   ###"
        echo "#################################################"
    
        # pull docker-compose file from github
        echo "    1. Pulling a default Wordpress, MYSQL and Adminer docker-compose.yml file."

        mkdir -p docker/wordpress-mysql-adminer
        cd docker/wordpress-mysql-adminer

        curl https://raw.githubusercontent.com/shawshanck/Wordpress-on-Docker/main/wordpress-mysql-adminer.yml -o docker-compose.yml >> ~/docker-script-install.log 2>&1

        echo "    2. Running the docker-compose.yml to install and start Wordpress, MYSQL and Adminer"
        echo ""
        echo ""

          docker-compose up -d
          sudo docker-compose up -d

        echo -e "    3. You can find NGinX Proxy Manager files at ./docker/nginx-proxy-manager"
        echo -e ""
        echo -e "${NC}    Navigate to your ${GREEN}server hostname / IP address ${NC}on ${GREEN}port 81${NC} to setup${NC}"
        echo -e "    Example: 0.0.0.0:81"
        echo -e ""
        echo -e ""
        echo -e "    The default login credentials for NGinX Proxy Manager are:"
        echo -e "${GREEN}        username: ${CYAN}admin@example.com${NC}"
        echo -e "${GREEN}        password: ${CYAN}changeme${NC}"

        echo -e ""
        echo -e ""
        echo -e "      ${CYAN}Provided to you by ${YELLOW}Mohammad Mohammadpour${NC}"
        echo -e "          ${YELLOW}https://github.com/shawshanck${NC}"
        echo -e ""
        cd
    fi
    
    exit 1
}

echo ""
echo ""

clear

echo -e "${YELLOW}Let's figure out which OS / Distro you are running.${NC}"
echo -e ""
echo -e ""
echo -e "${GREEN}    From some basic information on your system, you appear to be running: ${NC}"
echo -e "${GREEN}        --  OS Name            ${NC}" $(lsb_release -i)
echo -e "${GREEN}        --  Description        ${NC}" $(lsb_release -d)
echo -e "${GREEN}        --  OS Version         ${NC}" $(lsb_release -r)
echo -e "${GREEN}        --  Code Name          ${NC}" $(lsb_release -c)
echo -e ""
echo -e "${YELLOW}------------------------------------------------${NC}"
echo -e ""

PS3="Please enter 1 to install NGinX Proxy Manager or 2 to exit setup. "
select _ in \
    "Install Wordpress, MYSQL and Adminer" \
    "Exit"
do
  case $REPLY in
    1) installApps ;;
    2) exit ;;
    *) echo "Invalid selection, please try again..." ;;
  esac
done
