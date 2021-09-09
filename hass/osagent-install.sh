#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#   Install OSAgent
###############################################################
# Install pre-required OSAgent for HA Supervised
apt-get install -y udisks2 libglib2.0-bin

# Install OSAgent
wget https://github.com/home-assistant/os-agent/releases/download/1.1.1/os-agent_1.1.1_linux_aarch64.deb
dpkg -i os-agent_1.1.1_linux_aarch64.deb

echo -e "OSAgent installed \e[32m[DONE]\033[0m"