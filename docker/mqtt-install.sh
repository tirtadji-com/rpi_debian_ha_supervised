#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
#  Install Docker MQTT
###############################################################
NEW_USER=$1

while [[ $NEW_USER = "" ]]; do
   read -p "Please insert the new username, eg. John: " NEW_USER
done

# open port 9001 for HA
ufw allow 1883
ufw allow 9001
service ufw restart

# Making Directory for docker container 
mkdir /home/$NEW_USER/docker/mqtt
mkdir /home/$NEW_USER/docker/mqtt/config
mkdir /home/$NEW_USER/docker/mqtt/log
mkdir /home/$NEW_USER/docker/mqtt/data

docker run --name="mqtt" --restart=always --net=host -tid -p 1883:1883 -p 9001:9001 -v /home/$NEW_USER/docker/mqtt/config:/mosquitto/config:ro -v /home/$NEW_USER/docker/mqtt/log:/mosquitto/log -v /home/$NEW_USER/docker/mqtt/config/mosquitto.passwd:/mosquitto/config/mosquitto.passwd -v /home/$NEW_USER/docker/mqtt/data/:/mosquitto/data/ eclipse-mosquitto

echo -e "MQTT installed \e[32m[DONE]\033[0m"