#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Debian 10 + HA Supervised  
#   Install Fail2Ban
###############################################################
apt-get install -y fail2ban

systemctl start fail2ban
systemctl enable fail2ban

echo -e "Fail2Ban Installed \e[32m[DONE]\033[0m"