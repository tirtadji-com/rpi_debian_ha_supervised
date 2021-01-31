#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
#   Install Glances
###############################################################
apt install glances -y

# Stop glances for HASS preparation
service glances stop

# Allowing glances on webs
sed -i -r -e 's/-s -B 127.0.0.1/--disable-plugin cloud -w/g' /lib/systemd/system/glances.service

# Restart services
systemctl daemon-reload
service glances start

echo -e "Glances installed \e[32m[DONE]\033[0m"