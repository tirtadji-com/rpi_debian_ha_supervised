#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 10 + HA Supervised  
#  Install Docker InFlux DB
###############################################################
# open port 8006 for HA
ufw allow 8006
service ufw restart

# Making Directory for docker container 
mkdir /usr/share/hassio/docker/influxdb

# Install influxdb
docker run --rm influxdb influxd config | tee /etc/influxdb/influxdb.conf > /dev/null
docker run -d -p 8086:8086 --restart=always --net=host --name="influxdb" -v /etc/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf -v /usr/share/hassio/docker/influxdb:/var/lib/influxdb influxdb -config /etc/influxdb/influxdb.conf

echo -e "InfluxDB installed \e[32m[DONE]\033[0m"