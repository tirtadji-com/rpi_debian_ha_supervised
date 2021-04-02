#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Debian 10 + HA Supervised  
#  Install Docker MQTT
###############################################################
# open port 9001 for HA
#ufw allow 1883
#ufw allow 9001
#service ufw restart

# Making Directory for docker container 
mkdir /usr/share/hassio/docker/mqtt
mkdir /usr/share/hassio/docker/mqtt/config
mkdir /usr/share/hassio/docker/mqtt/log
mkdir /usr/share/hassio/docker/mqtt/data

docker run --name="mqtt" --restart=always --net=host -tid -p 1883:1883 -p 9001:9001 -v /usr/share/hassio/docker/mqtt/config:/mosquitto/config:ro -v /usr/share/hassio/docker/mqtt/log:/mosquitto/log -v /usr/share/hassio/docker/mqtt/config/mosquitto.passwd:/mosquitto/config/mosquitto.passwd -v /usr/share/hassio/docker/mqtt/data/:/mosquitto/data/ eclipse-mosquitto

echo -e "MQTT installed \e[32m[DONE]\033[0m"