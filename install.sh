#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color
myIP="$(dig +short myip.opendns.com @resolver1.opendns.com)"

installApps()
{
    clear
    OS="$REPLY" ## <-- This $REPLY is about OS Selection
    echo -e "${NC}You can Install ${GREEN}Wordpress, MYSQL and phpMyAdmin${NC} with this script!${NC}"
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
    
    read -rp "Wordpress, MYSQL and phpMyAdmin (y/n): " WMP

    startInstall
}

startInstall() 
{
    clear
    echo -e "*******************************************************"
    echo -e "***         Preparing for Installation              ***"
    echo -e "*******************************************************"
    echo -e ""
    sleep 3s


    if [[ "$WMP" == [yY] ]]; then
        echo -e "*******************************************************"
        echo -e "***     Install Wordpress, MYSQL & phpMyAdmin       ***"
        echo -e "*******************************************************"
    
        # Starting bash to create user defined parameters
        echo -e "${MAGENTA}      1.${NC}${GREEN} Please define each parameters:${NC}"

        mkdir -p docker/wordpress-mysql-phpmyadmin
        cd docker/wordpress-mysql-phpmyadmin

read -e -p "Please enter a Port for Wordpress: " -i "8181" wpp
wpp=${wpp:-"8181"}

read -e -p "Please create a Username for Database: " -i "exampleuser" dusr
dusr=${dusr:-"exampleuser"}

read -e -p "Please create a Password for Database: " -i "examplepass" dpss
dpss=${dpss:-"examplepass"}

read -e -p "Please create a Name for Database: " -i "exampledb" dbnm
dbnm=${dbnm:-"exampledb"}

read -e -p "Please create a "Root" Password for Database: " -i "notSecureChangeMe" rpss
rpss=${rpss:-"notSecureChangeMe"}

read -e -p "Please enter a Port for phpMyAdmin: " -i "8282" ppp
ppp=${ppp:-"8282"}

echo "version: '2.1'

services:

  wordpress:
    image: wordpress
    restart: always
    ports:
      - ${wpp:-"8181"}:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: ${dusr:-"exampleuser"}
      WORDPRESS_DB_PASSWORD: ${dpss:-"examplepass"}
      WORDPRESS_DB_NAME: ${dbnm:-"exampledb"}
    volumes:
      - /root/docker/wordpress:/var/www/html
    links:
      - db:db

  db:
    image: mysql:5.7
    restart: always
    ports:
      - 3306:3306
    environment:
      MYSQL_DATABASE: ${dbnm:-"exampledb"}
      MYSQL_USER: ${dusr:-"exampleuser"}
      MYSQL_PASSWORD: ${dpss:-"examplepass"}
      MYSQL_ROOT_PASSWORD: ${rpss:-"notSecureChangeMe"}
    volumes:
      - /root/docker/wordpress/db:/var/lib/mysql

  phpmyadmin:
    image: phpmyadmin
    restart: always
    ports:
      - ${ppp:-"8282"}:80
    environment:
      - PMA_ARBITRARY=1
    links:
      - db:db
      

volumes:
  wordpress:
  db:
  phpmyadmin:" > docker-compose.yml



	echo ""        
	echo -e "${MAGENTA}      2.${NC}${GREEN} Running the docker-compose.yml to install and start Wordpress, MYSQL and phpMyAdmin${NC}"
        echo ""
        echo ""

          docker-compose up -d
          sudo docker-compose up -d

	echo ""
	echo -e "${MAGENTA}      3.${NC}${GREEN} Installation Completed. Details are:${NC}"
        echo -e ""
        echo -e "${NC}     Wordpress is running on: http://${GREEN}${myIP}:${wpp:-"8181"}${NC}"
        echo -e ""
        echo -e "${NC}     Database Username: ${dusr:-"exampleuser"}"
        echo -e "${NC}     Database Password: ${dpss:-"examplepass"}"
        echo -e "${NC}     Database Name: ${dbnm:-"exampledb"}"
        echo -e ""
        echo -e "${NC}     phpMyAdmin is running on: http://${GREEN}${myIP}:${ppp:-"8282"}${NC}"
        echo -e "${NC}     phpMyAdmin Server: ${GREEN}${myIP}${NC}"
        echo -e "${NC}     phpMyAdmin Username: ${GREEN}root${NC}"
        echo -e "${NC}     phpMyAdmin Password: ${GREEN}${rpss:-"notSecureChangeMe"}${NC}"

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

PS3="Please enter 1 to install Wordpress, MYSQL and phpMyAdmin or 2 to exit setup. "
select _ in \
    "Install Wordpress, MYSQL and phpMyAdmin" \
    "Exit"
do
  case $REPLY in
    1) installApps ;;
    2) exit ;;
    *) echo "Invalid selection, please try again..." ;;
  esac
done
