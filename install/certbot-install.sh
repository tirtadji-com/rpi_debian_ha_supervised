#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
# Basic script for server
###############################################################
# Install CertBot
apt-get install certbot python-certbot-nginx -y

# support cloudflare plugins for star.dns
apt-get install python3-certbot-dns-cloudflare -y 

echo -e "Certbot Installed \e[32m[DONE]\033[0m"