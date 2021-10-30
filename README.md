# This installation will help you install HA Superviser on Debian 11
Home-Assistant Supervisor on Raspberry Pi 4 running Debian 11 complies with ADR-0014. Additional uncomplies are NGINX, Certbot, Glance, Portainer and other docker container should you install it. I just dont like to run my docker under supervisor account.

# Changes
I'm removing NGINX Installer and replacing it with NGINX Proxy Manager which I think will make your live easier rather then have to setup NGINX config manually. To login to NGINX Proxy Manager simple go to IP:81 and for the first time you will need to login as admin@example.com with password: changeme.

Portainer is now part of the installation, so you can easily check if there are problem with HA + Supervised Installation. To access portainer simply go to http://IP:9000

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

# Default installation is for HA + Portainer
You can access **portainer** by running it on your browser at `http://<YOUR-IP>:9000`

# Install Additional Docker Apps
**UPDATE**
Supervised is now exclusive for HA only, so additional docker on the same machine will have to run from HA. Due to this issue I will remove all other docker installation accept for NGINX Proxy Manager which I think will causing HA Supervised will become an unsupported OS. Have to see how can I fixed this.

**Non Docker-Apps:**
- Samba as default will be installed
- Glaces running on port 61208
- Home-Assistant on port 8123

## Thank you and  Cheers

If you like the scripts you can always

<a href="https://www.buymeacoffee.com/rltirtadji"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=rltirtadji&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff"></a>