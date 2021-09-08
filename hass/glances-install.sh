#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#   Install Glances
###############################################################
# Install pre-required applications for Debian 11
apt install -y python3 python3-pip
pip3 install glances[all]

# Prepare Glances as services
cat <<EOF >/lib/systemd/system/glances.service
[Unit]
Description=Glances
Documentation=man:glances(1)
Documentation=https://github.com/nicolargo/glances
After=network.target

[Service]
ExecStart=/usr/local/bin/glances --disable-plugin cloud -w
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

## Enable Glances
systemctl daemon-reload
systemctl enable glances

## Start Services
service glances start

echo -e "Glances installed \e[32m[DONE]\033[0m"