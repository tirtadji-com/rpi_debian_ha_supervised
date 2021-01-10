#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
# Basic script for server
###############################################################
apt install glances -y

# Stop glances for HASS preparation
service glances stop

# Allowing glances on webs
sed -i -r -e 's/-s/--disable-plugin cloud -w/g' /lib/systemd/system/glances.service

# Restart services
systemctl daemon-reload
service glances start

echo -e "Glances installed \e[32m[DONE]\033[0m"