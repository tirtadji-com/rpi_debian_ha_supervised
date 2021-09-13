#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
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
  local FLAG="\e[91m[ERROR:LXC] \e[93m$EXIT@$LINE"
  msg "$FLAG $REASON"
  exit $EXIT
}
function msg() {
  local TEXT="$1"
  echo -e "$TEXT"
}

# Prerequisite Apps for HA
apt-get install -y software-properties-common apparmor-utils dbus jq network-manager &>/dev/null
msg "Install HA Supervised Prerequisite Apps - \e[32m[DONE]\033[0m"

systemctl disable ModemManager >/dev/null
systemctl stop ModemManager >/dev/null
msg "Disable and stop ModemManager - \e[32m[DONE]\033[0m"

rm -rf /etc/machine-id
rm -rf /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
dbus-uuidgen --ensure
service docker restart
msg "Fixed machine-id and restart docker - \e[32m[DONE]\033[0m"

service docker restart

# Install HA Supervised
curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh &>/dev/null
bash installer.sh --machine raspberrypi4-64
msg "HA Superviser Installed - \e[32m[DONE]\033[0m"

# Cleanup container
msg "Cleanup..."
rm -rf /root/docker/hass-install.sh