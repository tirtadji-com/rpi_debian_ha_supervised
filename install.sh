#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
###############################################################
apt-get update && apt-get dist-upgrade -y && apt autoremove -y
apt-get -y install unzip lsb-release wget locales locales-all git figlet lolcat debconf-utils curl gnupg2 ca-certificates apt-transport-https

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
rm /root/main.sh
rm -rf /root/motd
/root/home-assistant.sh
rm /root/home-assistant.sh
rm /root/install/docker-install.sh
rm /root/install/fail2ban-install.sh
rm /root/hass/glances-install.sh
rm /root/hass/samba-install.sh
rm /root/hass/agentos-install.sh
rm /root/docker/hass-install.sh
rm /root/docker/portainer-install.sh

echo -e "HA installation complete"