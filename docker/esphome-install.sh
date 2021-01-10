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

# open port 6052 & 6123 for HA
ufw allow 6052
ufw allow 6123
service ufw restart


# Making Directory for docker container 
mkdir /home/$NEW_USER/docker/home-assistant/esphome

docker run -d --name="esphome" --net=host -p 6052:6052 -p 6123:6123 -e TZ=Asia/Jakarta -v /home/$NEW_USER/docker/home-assistant/esphome:/config esphome/esphome:latest