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

# Update Debian 11
msg "Installation begin and it will take a several minute to complete"
apt-get update >/dev/null
apt-get dist-upgrade -y &>/dev/null
apt autoremove -y &>/dev/null
msg "Updating your Debian 11 - \e[32m[DONE]\033[0m"

# Check Procedure
set +u
OS_NAME='lsb_release -is'
CODE_NAME='lsb_release -cs'

if [ $(id -u) -ne 0 ]; then
  msg "You must run this script as a ROOT"
	exit 1
fi

if [[ $OS_NAME -ne Debian ]]; then
  msg "You must run this script on Debian Machine"
	exit 1
fi

if [[ $CODE_NAME -ne bullseye ]]; then
  msg "The script support Debian 11 aka bullseye only"
	exit 1
fi

apt-get -y install sudo unzip lsb-release git &>/dev/null
cd ~
msg "Installing and Checking Prerequisite application - \e[32m[DONE]\033[0m"

wget https://github.com/tirtadji-com/rpi_debian_ha_supervised/archive/main.zip &>/dev/null
unzip /root/main.zip -d /root/ &>/dev/null
result=`ls -F /root/ | grep /`
mv /root/$result/* /root/
rm -r /root/$result
chmod +x /root/*.sh
chmod +x /root/install/*.sh
chmod +x /root/hass/*.sh
chmod +x /root/docker/*.sh
rm /root/main.zip
/root/home-assistant.sh

# Cleanup container
msg "Cleanup..."
rm -rf /root/motd /root/install.sh /var/{cache,log}/* /var/lib/apt/lists/*

# Reboot Now
msg "The System will REBOOT..."
reboot now