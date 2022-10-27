# This installation will help you install HA Superviser on Debian 11
Home-Assistant Supervisor on Raspberry Pi 4 running Debian 11 complies with ADR-0014. Additional uncomplies are NGINX, Certbot, Glance, Crowdsec and Samba which is automatically installed. Remember HA Supervised will announce uncompatible if you install any docker container.

# Changes
I'm putting back NGINX Installer and its addon since HA Supervised does not allow any docker container running on the same machine.

Sorry no more Portainer.

# Old Youtube Video to help you
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/yMEryGN_2MY/0.jpg)](https://www.youtube.com/watch?v=yMEryGN_2MY/0)


# Requirement:
- Rasberry Pi 4
- microSD or SSD Drive (which compatible with linux)
- Debian 11 Bulleye for RPI [download here](https://raspi.debian.net/tested-images/)
- Raspbian Imager [download here](https://www.raspberrypi.org/software/)
- Your public ssh keys (please google it on how to create one for you)
- If you did not used SSH Key you will need monitor and mouse and keyboard

# WARNING!
If you would like to run NGINX with your own domain make sure you open your router port 80/443 and directed to your RPI-ip else you dont need to install or running NGINX

# Installation:
**step 1**: Burn your microSD or SSD using Raspberry Pi Imager with Debian images  
**step 2**: Detach your microSD/SSD and reattached it to your computer  
**step 3**: Now go to your microSD/SSD directory and be sure to type using terminal `touch ssh` (we are going to install HA headless)  
**step 4**: Edit `sysconf.txt` and be sure to add this informations

```
# root_pw - Set a password for the root user (by default, it allows
# for a passwordless login)
root_pw=password

# DO NOT Changes this line if you dont want to used SSH Key
# root_authorized_key - Set an authorized key for a root ssh login.
# input your public ssh key here else you wont be able to login headless
root_authorized_key=ssh-rsa xxxxxxxxxxxx youremail@gmail.com
```

**step 5**: Boot your microSD/SSD from your Raspberry Pi and find the local IP
step 6: Now SSH to your RPI by using `ssh root@local-ip` and enter your SSH password

# Run this first and reboot your system
`apt-get update && apt-get dist-upgrade -y && apt autoremove -y && apt install wget -y`

**step 6**: Then execute this from your terminal

`wget https://raw.githubusercontent.com/tirtadji-com/rpi_debian_ha_supervised/main/install.sh && bash install.sh`

**Non Docker-Apps:**
- Samba as default will be installed
- Glaces running on port 61208
- Home-Assistant on port 8123
- NGINX + Certbot
- Crowdsec Firewall

## Thank you and  Cheers

If you like the scripts you can always

<a href="https://www.buymeacoffee.com/rltirtadji"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=rltirtadji&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff"></a>