#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#  Install Docker
###############################################################
# Install Docker
#apt-get -y install docker-ce=5:20.10.8~3-0~debian-bullseye docker-ce-cli=5:20.10.8~3-0~debian-bullseye containerd.io=1.4.9-1

## Manual install docker latest
apt-get -y install curl gnupg2 ca-certificates apt-transport-https
# curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# apt-get -y update
# apt-get -y install docker-ce docker-ce-cli containerd.io

## Begin Docker Installation
curl -fsSL get.docker.com | sh

echo -e "Docker Installed \e[32m[DONE]\033[0m"