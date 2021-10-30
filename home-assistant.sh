#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
# Install Main Setup first
/root/main.sh

# Install Docker
/root/install/docker-install.sh

# Install HASS
/root/docker/hass-install.sh

# Install AgentOS
/root/hass/osagent-install.sh

# Install Glances
/root/hass/glances-install.sh

# Install Samba
/root/hass/samba-install.sh

# Begin Installation NGINX
read -p "Do you want to install NGINX Proxy Manager (y/n): " NGX
case "$NGX" in 
  [yY] | [yY][eE][sS])
    /root/docker/npm-install.sh
    ;;
  *)
    echo "Please enter y/yes or n/no"
    ;;
esac

# Install Fail2Ban
/root/install/fail2ban-install.sh

# Cleanup container
rm -rf /root/install/home-assistant.sh /root/homeassistant-supervised.deb