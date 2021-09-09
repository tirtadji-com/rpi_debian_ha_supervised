#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#  Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Basic script for server
###############################################################
# Stop hassio-supervisor
service hassio-supervisor stop
rm -rf /etc/machine-id
rm -rf /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
dbus-uuidgen --ensure

service docker restart

echo -e "Fixed and restart Docker \e[32m[DONE]\033[0m"