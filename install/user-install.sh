#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#  Auto installer for Raspberry on Debian 10 + HA Supervised  
#  Create SUDO new user
###############################################################
NEW_USER=$1
while [[ $NEW_USER = "" ]]; do
   read -p "Please insert the new username, eg. john: " NEW_USER
done

adduser --disabled-password --shell /bin/bash --gecos "$NEW_USER" $NEW_USER
usermod -aG sudo $NEW_USER

echo -e "Create User $NEW_USER \e[32m[DONE]\033[0m"
