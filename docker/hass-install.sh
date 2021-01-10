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

# open port 8123 for HA
ufw allow 8123
service ufw restart

# Making Directory for docker container 
mkdir /home/$NEW_USER/docker/home-assistant

# Make sure its running on the right folder
chown -R $NEW_USER: /home/$NEW_USER/docker/

# Installation portainer and watchtower
docker run --name="portainer" -d --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /home/$NEW_USER/docker/portainer:/data  portainer/portainer-ce

# Install HA Supervised
curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh
bash installer.sh --machine raspberrypi4-64

echo -e "Home-Assistant installed \e[32m[DONE]\033[0m"