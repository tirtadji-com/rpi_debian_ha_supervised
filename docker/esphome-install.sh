#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
#  Install Docker ESPHome
###############################################################
TZONE=$1

while [[ $TZONE = "" ]]; do
  read -p "Write your timezone eg, Asia/Jakarta: " TZONE
done

# open port 6052 & 6123 for HA
ufw allow 6052
ufw allow 6123
service ufw restart


# Making Directory for docker container 
mkdir /usr/share/hassio/homeassistant/esphome

docker run -d --name="esphome" --net=host -p 6052:6052 -p 6123:6123 -e TZ=$TZONE -v /usr/share/hassio/homeassistant/esphome:/config esphome/esphome:latest