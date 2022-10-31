#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
$PWD/main.sh

# Install Main Setup first
read -p "Do you want to install NGINX (y/n): " NGX
if [ "$NGX" != "${NGX#[Yy]}" ]; then
  # Install NGINX
  $PWD/install/nginx-install.sh
  # Install Letsencrypt
  $PWD/install/certbot-install.sh
  # Prepare NGINX Config for HASS
  $PWD/install/nginx-hass-conf.sh
fi

# Install Docker
$PWD/install/docker-install.sh
# Install Glances
$PWD/install/glances-install.sh
# Install Samba
$PWD/install/samba-install.sh
# Install Crowdsec
$PWD/install/crowdsec-install.sh

# Begin the main installation
# Install AgentOS
$PWD/install/osagent-install.sh
# Install HASS
$PWD/install/hass-install.sh
# Install Glances


# Cleanup container
rm -rf $PWD/install/home-assistant.sh $PWD/homeassistant-supervised.deb