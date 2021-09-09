#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#  Install Docker Portainer
###############################################################
# Making Directory for docker container 
mkdir /usr/share/hassio/docker
mkdir /usr/share/hassio/docker/portainer

# Installation portainer and watchtower
docker run --name="portainer" -d --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/share/hassio/docker/portainer:/data portainer/portainer-ce

echo -e "Portainer installed \e[32m[DONE]\033[0m"