#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#   Auto installer for Debian 10 + HA Supervised  
#  Install Docker MySQL
###############################################################
MYSQLPASSWORD="$(openssl rand -base64 14)"

docker run -d -p 3306:3306 --restart=always --net=host --name "mysql" -v /usr/share/hassio/docker/mysql/conf.d:/etc/mysql/conf.d -v /usr/share/hassio/docker/mysql/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$MYSQLPASSWORD mysql --default-authentication-plugin=mysql_native_password

cat <<EOF >~/.mysqlrootpass
$MYSQLPASSWORD
EOF

echo -e "Docker mySQL Installed \e[32m[DONE]\033[0m"
