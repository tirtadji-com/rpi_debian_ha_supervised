#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
# Install NGINX
/root/install/nginx-install.sh

# Install Letsencrypt
/root/install/certbot-install.sh

# Prepare NGINX Config for HASS
/root/hass/nginx-hass-conf.sh

# Cleanup container
rm -rf /root/nginx.sh