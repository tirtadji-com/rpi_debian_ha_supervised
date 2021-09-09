#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#  Install Docker HA Supervisor
###############################################################
# Prerequisite Apps for HA
apt-get install -y software-properties-common apparmor-utils dbus jq network-manager udisks2 libglib2.0-bin
systemctl disable ModemManager
systemctl stop ModemManager

# Install HA Supervised
curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh
bash installer.sh --machine raspberrypi4-64

echo -e "Home-Assistant installed \e[32m[DONE]\033[0m"