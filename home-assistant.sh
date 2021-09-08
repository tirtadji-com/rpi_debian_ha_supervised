#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#  Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Basic script for server
###############################################################
# Begin Installation
read -p "Do you want to install NGINX (y/n): " NGX

if [ "$NGX" != "${NGX#[Yy]}" ]; then

# Install NGINX
/root/install/nginx-install.sh

# Install Letsencrypt
/root/install/certbot-install.sh

# Prepare NGINX Config for HASS
/root/hass/nginx-hass-conf.sh

fi

# Install Fail2Ban
/root/install/fail2ban-install.sh

# Install AgentOS
wget https://github.com/home-assistant/os-agent/releases/download/1.1.1/os-agent_1.1.1_linux_aarch64.deb
dpkg -i os-agent_1.1.1_linux_aarch64.deb

# Install Docker
/root/install/docker-install.sh

# Install Glances
/root/hass/glances-install.sh

# Install HASS
/root/docker/hass-install.sh

# Install Samba
/root/hass/samba-install.sh

echo -e "HASS.core Server installation \e[32m[DONE]\033[0m"