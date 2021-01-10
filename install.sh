#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
# 	Basic script for server
###############################################################
apt-get update && apt-get dist-upgrade -y && apt autoremove -y
apt-get -y install unzip lsb-release wget

# Check Procedure
LINUX='lsb_release -is'

if [ $(id -u) -ne 0 ]; then
	echo "Run this script as a Root user only" >&2
	exit 1
fi

if [[ $LINUX -ne Debian ]]; then
	echo "This script usage only for Debian" >&2
	exit 1
fi
cd ~

wget https://github.com/tirtadji-com/rpi_debian_ha_supervised/archive/main.zip
unzip /root/main.zip -d /root/
result=`ls -F /root/ | grep /`
mv /root/$result/* /root/
rm -r /root/$result
chmod +x /root/*.sh
chmod +x /root/install/*.sh
chmod +x /root/hass/*.sh
chmod +x /root/docker/*.sh
rm /root/main.zip
/root/main.sh

echo -e "HA installation complete"