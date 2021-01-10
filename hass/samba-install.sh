#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
# Basic script for server
###############################################################
NEW_USER=$1
PASS=$2

while [[ $NEW_USER = "" ]]; do
   read -p "Please insert the new username, eg. John: " NEW_USER
done

while [[ $PASS = "" ]]; do
  read -p "Your Samba Password: " PASS
done

apt install samba -y

mkdir /home/$NEW_USER/docker
chown -R $NEW_USER: /home/$NEW_USER/docker

cat <<EOF >>/etc/samba/smb.conf
[$NEW_USER]
  comment = Samba for ha
  path = /home/$NEW_USER
  read only = no
  browsable = yes
  writeable = yes
  guest ok = no
  create mask = 0644
  directory mask = 0755
  force user = root
EOF

echo -e "$PASS\n$PASS" | smbpasswd -s -a $NEW_USER

service smbd restart
ufw allow Samba

echo -e "Samba Installed \e[32m[DONE]\033[0m"