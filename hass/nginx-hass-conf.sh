#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
# Auto installer for Raspberry on Debian 11 + HA Supervised  
# NGINX Configurations for HA
###############################################################
HOST=$1
DOMAIN=$2
IP=$3
EMAIL=$4

read -p "Is this your main domain e.g. www (y/n): " MAIN

if [ "$MAIN" != "${MAIN#[Yy]}" ]; then

  HOST=www

while [[ $DOMAIN = "" ]]; do
  read -p "Write the 1st level domain name without starting dot (.), eg. example.com: " DOMAIN
done

while [[ $IP = "" ]]; do
  read -p "Write the local-ip for Home-Assistant, eg. 127.0.0.1: " IP
done

while [[ $EMAIL = "" ]]; do
  read -p "Your email for Letsencrypt: " EMAIL
done

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/$DOMAIN
server {
  listen 80;

  server_name $DOMAIN $HOST.$DOMAIN; 

  location / {
    return 301 https://$HOST.$DOMAIN\$request_uri;
  }
}
EOF

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/ssl-$DOMAIN
server {
  listen 443 ssl http2;

  server_name $HOST.$DOMAIN; 

  # SSL
  ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/$DOMAIN/chain.pem;

  # security
  include custom-snippets/security.conf;

  # logging
  access_log /var/log/nginx/$DOMAIN-access.log; 
  error_log /var/log/nginx/$DOMAIN-error.log;

  location / {
    proxy_pass http://$IP:8123;
    include custom-snippets/proxy.conf;
  }

  location /api/websocket {
    proxy_pass http://$IP:8123/api/websocket;
    include custom-snippets/proxy.conf;
  }
}

# subdomains redirect
  server {
  listen 443 ssl http2;

  server_name $DOMAIN;

  # SSL
  ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/$DOMAIN/chain.pem;

  return 301 https://$HOST.$DOMAIN\$request_uri; 
}
EOF

certbot certonly --no-eff-email -m $EMAIL --agree-tos --no-redirect --nginx -d $DOMAIN -d $HOST.$DOMAIN

# create link for nginx
ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN
ln -s /etc/nginx/sites-available/ssl-$DOMAIN /etc/nginx/sites-enabled/ssl-$DOMAIN

else

while [[ $HOST = "" ]]; do
  read -p "Write the subdomain name, eg. subdomain: " HOST
done

while [[ $DOMAIN = "" ]]; do
  read -p "Write the 1st level domain name without starting dot (.), eg. example.com: " DOMAIN
done

while [[ $IP = "" ]]; do
  read -p "Write the local-ip for that specific machine, eg. 127.0.0.1: " IP
done

while [[ $EMAIL = "" ]]; do
  read -p "Your email for Letsencrypt: " EMAIL
done

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/$HOST.$DOMAIN
server {
  listen 80;

  server_name $HOST.$DOMAIN; 

  location / {
    return 301 https://\$host\$request_uri;
  }
}
EOF

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/ssl-$HOST.$DOMAIN
server {
	listen 443 ssl http2;

  server_name $HOST.$DOMAIN; 

	# SSL
  ssl_certificate /etc/letsencrypt/live/$HOST.$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$HOST.$DOMAIN/privkey.pem;
	ssl_trusted_certificate /etc/letsencrypt/live/$HOST.$DOMAIN/chain.pem;

	# security
	include custom-snippets/security.conf;

	# logging
  access_log /var/log/nginx/$HOST.$DOMAIN-access.log; 
  error_log /var/log/nginx/$HOST.$DOMAIN-error.log;

  location / {
    proxy_pass http://$IP:8123;
    include custom-snippets/proxy.conf;
  }

  location /api/websocket {
    proxy_pass http://$IP:8123/api/websocket;
    include custom-snippets/proxy.conf;
  }
}
EOF

certbot certonly --no-eff-email -m $EMAIL --agree-tos --no-redirect --nginx -d $HOST.$DOMAIN

# create link for nginx
ln -s /etc/nginx/sites-available/$HOST.$DOMAIN /etc/nginx/sites-enabled/$HOST.$DOMAIN
ln -s /etc/nginx/sites-available/ssl-$HOST.$DOMAIN /etc/nginx/sites-enabled/ssl-$HOST.$DOMAIN

fi

service nginx restart

echo -e "NGINX PHP Setup \e[32m[DONE]\033[0m"

