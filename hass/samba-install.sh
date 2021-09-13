#!/usr/bin/env bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Raspberry on Debian 11 + HA Supervised  
# 	Installer scripts
# 	Additional script made by tteck
###############################################################
PASS=$1

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

while [[ $PASS = "" ]]; do
  read -p "Your Samba Password: " -s PASS
done

apt install samba -y &>/dev/null

cat <<EOF >>/etc/samba/smb.conf
[home-assistant]
  comment = Samba for home-assistant
  path = /usr/share/hassio
  read only = no
  browsable = yes
  writeable = yes
  guest ok = no
  create mask = 0644
  directory mask = 0755
  force user = root  
  force group = root  
EOF

echo -e "$PASS\n$PASS" | smbpasswd -s -a root

service smbd restart
msg "Samba Installed - \e[32m[DONE]\033[0m"

# Cleanup container
msg "Cleanup..."
rm -rf /root/hass/samba-install.sh