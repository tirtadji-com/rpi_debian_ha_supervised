#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Debian 10 + HA Supervised  
#  Install Docker TasmoAdmin
###############################################################
# open port 9003 for TasmoAdmin
#ufw allow 9003
#service ufw restart

# Making Directory for docker container 
mkdir /usr/share/hassio/docker/tasmoadmin

# Install TasmoAdmin
docker run -d --restart=always --name=tasmoadmin -v /usr/share/hassio/docker/tasmoadmin/data:/data -p 9003:80 raymondmm/tasmoadmin

echo -e "TasmoAdmin installed \e[32m[DONE]\033[0m"