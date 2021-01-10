#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
# Basic script for server
###############################################################
NEW_USER=$1

while [[ $NEW_USER = "" ]]; do
   read -p "Please insert the new username, eg. John: " NEW_USER
done

# Making Directory for docker container 
mkdir /home/$NEW_USER/docker/tasmoadmin

# Install TasmoAdmin
docker run -d --restart=always --name=tasmoadmin -v /home/$NEW_USER/docker/tasmoadmin/data:/data -p 9003:80 raymondmm/tasmoadmin

echo -e "TasmoAdmin installed \e[32m[DONE]\033[0m"