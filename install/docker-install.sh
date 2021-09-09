#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#  Install Docker
###############################################################
## Begin Docker Installation
curl -fsSL get.docker.com | sh

echo -e "Docker Installed \e[32m[DONE]\033[0m"