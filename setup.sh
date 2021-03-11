#!/bin/bash
############################################################
# Script Auto-Setup By LarchitecT
############################################################
# shellcheck disable=SC2006
# shellcheck disable=SC2034
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`
############################################################
# core functions
############################################################
function check_install {
    if [ -z "`which "$1" 2>/dev/null`" ]
    then
        executable=$1
        shift
        while [ -n "$1" ]
        do
            DEBIAN_FRONTEND=noninteractive apt-get -qq -o Dpkg::Use-Pty=0 install "$1"
            apt-get clean
            print_info "[ $1 ] installé avec succès !"
            shift
        done
    else
        print_warn "[ $2 ] déjà installé !"
    fi
}
############################################################
# Printer Color Functions
############################################################
function print_info {
    echo -n -e '\e[1;36m'
    echo -n "$1"
    echo -e '\e[0m'
}
function print_warn {
    echo -n -e '\e[1;33m'
    echo -n "$1"
    echo -e '\e[0m'
}
############################################################
# Install Home
############################################################
function install_home {
    echo  '
____  ___         ________  _______________   ____
\   \/  /         \______ \ \_   _____/\   \ /   /
 \     /   ______  |    |  \ |    __)_  \   Y   /
 /     \  /_____/  |    `   \|        \  \     /
/___/\  \         /_______  /_______  /   \___/
      \_/                 \/        \/          By LarchitecT


'  > /etc/motd
print_info "[ motd ] installé avec succès !"
}
############################################################
# Install build-essential
############################################################
function install_build {
    check_install build-essential nodejs
}
############################################################
# Install Git
############################################################
function install_git {
    check_install git git
}
############################################################
# Install Curl
############################################################
function install_curl {
    check_install curl curl
}
############################################################
# Install Curl
############################################################
function install_node {
    curl -sL https://deb.nodesource.com/setup_14.x | bash -
    check_install nodejs nodejs
    check_install npm npm
}
############################################################
# Install Curl
############################################################
function install_gtop {
    npm i gtop -g
    print_info "[ gtop ] installé avec succès !"
}
############################################################
# Install Unzip
############################################################
function install_unzip {
    check_install unzip unzip
}
############################################################
# Install Apache
############################################################
function install_apache {
    check_install apache2 apache2
}
############################################################
# Install Apache
############################################################
function install_ffmpeg {
    check_install ffmpeg ffmpeg
}
############################################################
# install_speedtest
############################################################
function install_speedtest {
    check_install gnupg1 gnupg1
    check_install apt-transport-https apt-transport-https
    check_install dirmngr dirmngr
    export INSTALL_KEY=379CE192D401AB61
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
    echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
    sudo apt-get update
    check_install speedtest speedtest
    print_info "[ speedtest ] installé avec succès !"
}
############################################################
# install_mariadb_server
############################################################
function install_mariadb_server {
    check_install mariadb-server mariadb-server
}
############################################################
# install_mariadb_client
############################################################
function install_mariadb_client {
    check_install mariadb-client mariadb-client
}
############################################################
# Install install_mysql
############################################################
function install_mysql {
    check_install mysql_secure_installation mysql_secure_installation
}
############################################################
# Install PM2
############################################################
function install_pm2 {
    npm i pm2 -g
    print_info "[ pm2 ] installé avec succès !"
}
############################################################
# Install create_mariadb_user
############################################################
function create_mariadb_user {
PASSWDDB="$(openssl rand -base64 12)"
MYIP=`hostname -I | awk '{print $1}'`
MAINDB=${HOSTNAME//[^a-zA-Z0-9]/_}

mysqladmin -u root password "$PASSWDDB"
# shellcheck disable=SC2086
mysql -uroot -p$PASSWDDB! -e "CREATE DATABASE $MAINDB"
# shellcheck disable=SC2086
mysql -uroot -p$PASSWDDB -e "GRANT ALL PRIVILEGES ON $MAINDB.* TO $MAINDB@localhost IDENTIFIED BY '$PASSWDDB'"
echo "Voici vos accès PhpMyAdmin
―――――――――――――――――――――――――――――――――――――――――――
PhpMyAdmin : http://$MYIP:9000
―――――――――――――――――――――――――――――――――――――――――――
Username   : $MAINDB
Password   : $PASSWDDB
―――――――――――――――――――――――――――――――――――――――――――
"  > /root/PhpMyAdmin_Accès.txt
echo "Voici ci-dessous vos accès PhpMyAdmin"
echo "―――――――――――――――――――――――――――――――――――――――――――"
echo "${magenta}PhpMyAdmin${reset} : ${green}http://$MYIP:9000${reset}"
echo "${magenta}Username${reset}   : ${green}${MAINDB}${reset}"
echo "${magenta}Password${reset}   : ${green}${PASSWDDB}${reset}"
echo "―――――――――――――――――――――――――――――――――――――――――――"
echo "${magenta}NOTE${reset}: ${green}Vos accès ont été enregistré dans${reset} ${blue}./root/PhpMyAdmin_Accès.txt${reset}"
echo "―――――――――――――――――――――――――――――――――――――――――――"
}
############################################################
# Install Apache_home
############################################################
function install_apache_home {
    rm /var/www/html/index.html
    wget https://github.com/L-architec-T/home/releases/download/1.0.0/index.zip
    unzip index.zip -d /var/www/html
    rm index.zip
    print_info "[ apache2 ] installé avec succès !"
}
############################################################
# Install Php
############################################################
function install_php {
    check_install php php
    check_install php-json php-json
    check_install php-mbstring php-mbstring
    check_install php-zip php-zip
    check_install php-gd php-gd
    check_install php-xml php-xml
    check_install php-curl php-curl
    check_install php-mysql php-mysql
}
############################################################
# Install PhpMyAdmin
############################################################
function install_phpmyadmin {
    wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.zip
    unzip phpMyAdmin-4.9.0.1-all-languages.zip -d /opt
    mv -v /opt/phpMyAdmin-4.9.0.1-all-languages /opt/phpMyAdmin
    sudo chown -Rfv www-data:www-data /opt/phpMyAdmin
    # shellcheck disable=SC2016
    echo '
    <VirtualHost *:9000>
    ServerAdmin webmaster@localhost
    DocumentRoot /opt/phpMyAdmin

    <Directory /opt/phpMyAdmin>
      Options Indexes FollowSymLinks
      AllowOverride none
      Require all granted
    </Directory>
      ErrorLog ${APACHE_LOG_DIR}/error_phpmyadmin.log
      CustomLog ${APACHE_LOG_DIR}/access_phpmyadmin.log combined
    </VirtualHost>
    '  > /etc/apache2/sites-available/phpmyadmin.conf
    rm -r phpMyAdmin-4.9.0.1-all-languages.zip
    print_info "[ phpMyAdmin.zip ] supprimé avec succès !"
    rm -r etc/apache2/ports.conf
    echo '
    Listen 80
    Listen 9000

    <IfModule ssl_module>
      Listen 443
    </IfModule>

    <IfModule mod_gnutls.c>
      Listen 443
    </IfModule>
    '  > /etc/apache2/ports.conf
    sudo a2ensite phpmyadmin.conf
}
############################################################
# Restart Apache
############################################################
function restart_apache {
    sudo service apache2 restart
    print_info "[ apache2 ] redemarré avec succès !"
}
############################################################
# Fix locale language
############################################################
function fix_locale {
    cp /etc/locale.gen /etc/locale.gen.old
    sed -i "s/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/g" /etc/locale.gen
    sed -i "s/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g" /etc/locale.gen
    sed -i "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen
    /usr/sbin/locale-gen
    export LANG=fr_FR.UTF-8
}
############################################################
# apt_clean
############################################################
function apt_clean {
    apt-get -q -y autoclean
    apt-get -q -y clean
}
############################################################
# update_upgrade
############################################################
function update_upgrade {
    apt-get -q -y update
    apt-get -q -y upgrade
    apt-get -q -y autoremove
}
############################################################
# update
############################################################
function update {
    apt-get -q -y update
}
########################################################################
# START OF PROGRAM
########################################################################
case "$1" in
*)
    #update_upgrade
    update
    install_home
    install_build
    install_node
    install_pm2
    install_gtop
    install_git
    install_curl
    install_unzip
    install_ffmpeg
    install_speedtest
    install_apache
    install_apache_home
    install_mariadb_server
    install_mariadb_client
    install_mysql
    install_php
    install_phpmyadmin
    restart_apache
    fix_locale
    create_mariadb_user

    #apt_clean
    ;;
esac