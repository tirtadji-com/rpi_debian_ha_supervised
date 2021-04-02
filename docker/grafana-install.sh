#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Debian 10 + HA Supervised  
#  Install Docker Grafana
###############################################################
# open port 3000 for HA
#ufw allow 3000
#service ufw restart

# Making Directory for docker container 
mkdir  /usr/share/hassio/docker/grafana

# Install grafana
docker run -d --user root --restart=always -p 3000:3000 --name="grafana" --net=host -v /usr/share/hassio/docker/grafana:/var/lib/grafana grafana/grafana

echo -e "Grafana installed \e[32m[DONE]\033[0m"