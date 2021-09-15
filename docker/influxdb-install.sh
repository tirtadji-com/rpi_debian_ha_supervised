#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
#  Install Docker InFlux DB 2.0
###############################################################

while [[ $USER = "" ]]; do
  read -p "Please input your username for influxDB: " USER
done

while [[ $PASS = "" ]]; do
  read -p "Your influxdb Password: " -s PASS
done

while [[ $ORG = "" ]]; do
  read -p "Please input your organizations: " ORG
done

# Making Directory for docker container
mkdir /usr/share/hassio/docker/influxdb

# Install influxdb
docker run -d -p 8086:8086 --name=influxdb --restart=always -v /usr/share/hassio/docker/influxdb/data:/var/lib/influxdb2 -v /usr/share/hassio/docker/influxdb/config:/etc/influxdb2 -e DOCKER_INFLUXDB_INIT_MODE=setup -e DOCKER_INFLUXDB_INIT_USERNAME=$USER -e DOCKER_INFLUXDB_INIT_PASSWORD=$PASS -e DOCKER_INFLUXDB_INIT_ORG=$ORG -e DOCKER_INFLUXDB_INIT_BUCKET=homeassistant influxdb:2.0.7
echo -e "InfluxDB 2.0 installed \e[32m[DONE]\033[0m"