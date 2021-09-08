#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# Basic script for server
###############################################################
PASS=$1

while [[ $PASS = "" ]]; do
  read -p "Your Samba Password: " -s PASS
done

apt install samba -y

cat <<EOF >>/etc/samba/smb.conf
[home-assistant]
  comment = Samba for home-assistant
  path = /usr/share/hassio
  read only = no
  browsable = yes
  writeable = yes
  guest ok = no
  create mask = 0644
  directory mask = 0755
  force user = root  
  force group = root  
EOF

echo -e "$PASS\n$PASS" | smbpasswd -s -a root

service smbd restart
#ufw allow Samba

echo -e "Samba Installed \e[32m[DONE]\033[0m"