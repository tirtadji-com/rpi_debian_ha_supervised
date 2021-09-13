#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
TZONE=$1

# Setup script environment
set -o errexit  #Exit immediately if a pipeline returns a non-zero status
set -o errtrace #Trap ERR from shell functions, command substitutions, and commands from subshell
set -o nounset  #Treat unset variables as an error
set -o pipefail #Pipe will exit with last non-zero status if applicable
shopt -s expand_aliases
alias die='EXIT=$? LINE=$LINENO error_exit'
trap die ERR
trap 'die "Script interrupted."' INT

function error_exit() {
  trap - ERR
  local DEFAULT='Unknown failure occured.'
  local REASON="\e[97m${1:-$DEFAULT}\e[39m"
  local FLAG="\e[91m[ERROR:HAInstall] \e[93m$EXIT@$LINE"
  msg "$FLAG $REASON"
  exit $EXIT
}
function msg() {
  local TEXT="$1"
  echo -e "$TEXT"
}

msg "Installing ESP Home..."

while [[ $TZONE = "" ]]; do
  read -p "Write your timezone eg, Asia/Jakarta: " TZONE
done

# Making Directory for docker container 
mkdir /usr/share/hassio/homeassistant/esphome

docker run -d --name="esphome" --net=host -p 6052:6052 -p 6123:6123 -e TZ=$TZONE -v /usr/share/hassio/homeassistant/esphome:/config esphome/esphome:latest

# Cleanup container
msg "Cleanup..."
rm -rf /root/docker/esphome-install.sh
msg "ESP Home Installed - \e[32m[DONE]\033[0m"