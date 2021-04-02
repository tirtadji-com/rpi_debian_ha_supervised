#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#  Auto installer for Debian 10 + HA Supervised  
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

# Install Docker
/root/install/docker-install.sh

# Install Samba
/root/hass/glances-install.sh

# Install Docker Component
/root/docker/influxdb-install.sh
/root/docker/mysql-install.sh
/root/docker/grafana-install.sh

# Install HASS
/root/docker/hass-install.sh

# Install Samba
/root/hass/samba-install.sh

echo -e "HASS.core Server installation \e[32m[DONE]\033[0m"