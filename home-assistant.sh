#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
function msg() {
  local TEXT="$1"
  echo -e "$TEXT"
}

# Install Docker
/root/install/docker-install.sh

# Install HASS
/root/docker/hass-install.sh

# Install AgentOS
/root/hass/osagent-install.sh

# Temp Fixed
#/root/fixed.sh

# Install Portainer
/root/docker/portainer-install.sh

# Install Glances
/root/hass/glances-install.sh

# Install Samba
/root/hass/samba-install.sh

# Begin Installation NGINX
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

/root/main.sh

# Cleanup container
msg "Cleanup..."
rm -rf /root/install/home-assistant.sh