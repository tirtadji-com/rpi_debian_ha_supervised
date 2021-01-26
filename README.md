# This installation will help you install
Home-Assistant Supervisor on Raspberry Pi 4 running Debian 10 complies with ADR-0014. Additional uncomplies are NGINX, Certbot, Glance, Portainer and other docker container should you install it. I just dont like to run my docker under supervisor account.

# Requirement:
- Rasberry Pi 4
- microSD or SSD Drive (which compatible with linux)
- Debian 10 for RPI [download here](https://raspi.debian.net/tested-images/)
- Raspbian Imager [download here](https://www.raspberrypi.org/software/)
- Your public ssh keys (please google it on how to create one for you)
- If you did not used SSH Key you will need monitor and mouse and keyboard

# WARNING!
Before you if you would like to run NGINX with your own domain make sure you open your router port 80/443 and directed to your RPI-ip else you dont need to install or running NGINX

# Installation:
**step 1**: Burn your microSD or SSD using Raspberry Pi Imager with Debian images  
**step 2**: Detach your microSD/SSD and reattached it to your computer  
**step 3**: Now go to your microSD/SSD directory `boot` and be sure to type using terminal `touch ssh` (we are going to install HA headless)  
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

`wget https://raw.githubusercontent.com/tirtadji-com/rpi_debian_ha_supervised/main/install.sh`

**step 7**: Now you will need to execute the scripts from your ROOT Directory

# Execute the script
`bash install.sh`


# Install Additional Docker Apps
If you want to install more docker application for your Home-Assistant then you will have to run each individual script inside docker directory accept for hass-install.sh (remember this installation will not complies with ADR-0014)

To install simply by `cd /root/docker` and type `./[docker-apps]-install.sh`
**Docker-Apps:**

- Portainer running on port 9000
- Grafana running on port 3000
- ESP Home running on port 6052
- InfluxDB running on port 8086
- MotionEye running on port 8765
- MQTT running on port 1883
- TasmoAdmin running on port 9003
- WatchTower

**Non Docker-Apps:**

- Glaces running on port 61208
- Home-Assistant on port 8123

# Portainer

For those who never used Portainer please run this apps first, this will allow you to see your docker dashboard and allowing you to control your docker apps installed on your RPI. More information regarding portainer can be read at portainer.io

# NGINX Installation

IF you did not setup NGINX on your first installation and would like to add it up you can run `./nginx.sh` from your root directory.
