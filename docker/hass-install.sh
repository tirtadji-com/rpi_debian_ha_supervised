#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#  Install Docker HA Supervisor
###############################################################
# open port 8123 for HA
#ufw allow 8123
#service ufw restart

# Install HA Supervised
curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh
bash installer.sh --machine raspberrypi4-64

# Making Directory for docker container 
mkdir /usr/share/hassio/docker
mkdir /usr/share/hassio/docker/portainer

# Installation portainer and watchtower
docker run --name="portainer" -d --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/share/hassio/docker/portainer:/data portainer/portainer-ce

echo -e "Home-Assistant installed \e[32m[DONE]\033[0m"