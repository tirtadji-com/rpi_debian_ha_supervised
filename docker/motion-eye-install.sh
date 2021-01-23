#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
#  Install Docker MotionEye
###############################################################
# open port 8765 for HA
ufw allow 8765
service ufw restart

# Making Directory for docker container 
mkdir /usr/share/hassio/docker/motioneye
mkdir /usr/share/hassio/docker/motioneye/recordings

docker run -itd --restart=always --name=motioneye --net=host -p 8765:8765 -v /etc/localtime:/etc/localtime:ro -v /usr/share/hassio/docker/motioneye:/etc/motioneye -v /usr/share/hassio/docker/motioneye/recordings:/var/lib/motioneye  ccrisan/motioneye:master-armhf

echo -e "MotionEye installed \e[32m[DONE]\033[0m"