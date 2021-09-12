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

clear
# Install pre-required applications for Debian 11
apt install -y python3 python3-pip &>/dev/null
pip3 install glances[all] &>/dev/null
msg "Installed Prerequisite for Glances - \e[32m[DONE]\033[0m"

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
msg "Glances Installed - \e[32m[DONE]\033[0m"

# Cleanup container
msg "Cleanup..."
rm -rf /root/hass/glances-install.sh /var/{cache,log}/* /var/lib/apt/lists/*