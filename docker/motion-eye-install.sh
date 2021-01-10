#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
#  Install Docker MotionEye
###############################################################
NEW_USER=$1

while [[ $NEW_USER = "" ]]; do
   read -p "Please insert the new username, eg. John: " NEW_USER
done

# open port 8765 for HA
ufw allow 8765
service ufw restart

# Making Directory for docker container 
mkdir /home/$NEW_USER/docker/motioneye
mkdir /home/$NEW_USER/docker/motioneye/recordings

docker run -itd --restart=always --name=motioneye --net=host -p 8765:8765 -v /etc/localtime:/etc/localtime:ro -v /home/$NEW_USER/docker/motioneye:/etc/motioneye -v /home/$NEW_USER/docker/motioneye/recordings:/var/lib/motioneye  ccrisan/motioneye:master-armhf

echo -e "MotionEye installed \e[32m[DONE]\033[0m"