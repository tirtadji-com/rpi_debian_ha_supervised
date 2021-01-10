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

# open port 3000 for HA
ufw allow 3000
service ufw restart

# Making Directory for docker container 
mkdir /home/$NEW_USER/docker/grafana

# Install grafana
docker run -d --user root --restart=always -p 3000:3000 --name="grafana" --net=host -v /home/$NEW_USER/docker/grafana:/var/lib/grafana grafana/grafana-arm64v8-linux

echo -e "Grafana installed \e[32m[DONE]\033[0m"