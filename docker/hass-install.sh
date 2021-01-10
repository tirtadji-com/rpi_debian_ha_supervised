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

# Install home-assistant + Portainer
docker run -id --name="home-assistant" --restart=always -p 8123:8123 --net=host -e "TZ=Asia/Jakarta" -v /home/$NEW_USER/docker/home-assistant:/config -v /home/$NEW_USER/docker/home-assistant/media:/media -v /etc/letsencrypt/live:/certificate homeassistant/home-assistant

echo -e "Home-Assistant installed \e[32m[DONE]\033[0m"