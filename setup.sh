#!/bin/bash

############################################################
# Script Auto-Setup By LarchitecT
############################################################
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
reset="$(tput sgr0)"
echo "
   _____      __                    ______            ____
  / ___/___  / /___  ______        / ____/___  ____  / __/
  \__ \/ _ \/ __/ / / / __ \______/ /   / __ \/ __ \/ /_
 ___/ /  __/ /_/ /_/ / /_/ /_____/ /___/ /_/ / / / / __/
/____/\___/\__/\__,_/ .___/      \____/\____/_/ /_/_/
                   /_/
                                            By LarchitecT
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
############################################################
# core functions
############################################################
if [ "$(whoami)" != 'root' ]
  then
    echo "Veuillez executer en root !!"
    exit
fi
############################################################
function check_install {
    if [ -z "$(which "$1" 2>/dev/null)" ]
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
        apt --fix-broken install
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

―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
'  > /etc/motd
print_info "[ motd ] installé avec succès !"
}
############################################################
# Install build-essential
############################################################
function install_dos2unix {
    sudo apt-get install dos2unix
}
############################################################
# Install proxy_http
############################################################
function install_proxy_http {
    a2enmod proxy proxy_http
    print_info "[ proxy_http ] installé avec succès !"
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
# Install Node 
############################################################
function install_node {
    curl -sL https://deb.nodesource.com/setup_14.x | bash -
    check_install nodejs nodejs
    check_install npm npm
    print_info "[ node ] installé avec succès !"
}
############################################################
# Install Gtop
############################################################
function install_gtop {
    npm i gtop -g
    print_info "[ gtop ] installé avec succès !"
}
############################################################
# Install nNdemon
############################################################
function install_nodemon {
    npm i nodemon -g
    print_info "[ nodemon ] installé avec succès !"
}
############################################################
## Install BashTop
#############################################################
function install_bashtop {
    git clone https://github.com/aristocratos/bashtop.git
    cd bashtop/
    cd DEB
    sudo ./build
    print_info "[ bashtop ] installé avec succès !"
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
# Install ffmpeg
############################################################
function install_ffmpeg {
    check_install ffmpeg ffmpeg
}
############################################################
# Install Fail2Ban
############################################################
function install_fail2ban {
    check_install fail2ban fail2ban
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
MYIP="$(hostname -I | awk '{print $1}')"
MAINDB="${HOSTNAME//[^a-zA-Z0-9]/_}"

mysqladmin -u root password "$PASSWDDB"

mysql -uroot -p"$PASSWDDB" -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -uroot -p"$PASSWDDB" -e "CREATE USER $MAINDB@localhost IDENTIFIED BY '$PASSWDDB';"
mysql -uroot -p"$PASSWDDB" -e "GRANT ALL PRIVILEGES ON $MAINDB.* TO $MAINDB@localhost IDENTIFIED BY '$PASSWDDB';"
mysql -uroot -p"$PASSWDDB" -e "FLUSH PRIVILEGES;"
mysql -uroot -p"$PASSWDDB" -e "QUIT"

/etc/init.d/mysql stop
/etc/init.d/mysql start

echo "
   _____      __                    ______            ____
  / ___/___  / /___  ______        / ____/___  ____  / __/
  \__ \/ _ \/ __/ / / / __ \______/ /   / __ \/ __ \/ /_
 ___/ /  __/ /_/ /_/ / /_/ /_____/ /___/ /_/ / / / / __/
/____/\___/\__/\__,_/ .___/      \____/\____/_/ /_/_/
                   /_/
                                            By LarchitecT

―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
Voici vos accès PhpMyAdmin
―――――――――――――――――――――――――――――――――――――――――――
PhpMyAdmin : http://$MYIP:9000
―――――――――――――――――――――――――――――――――――――――――――
Username   : $MAINDB
Password   : $PASSWDDB
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"  > /root/PhpMyAdmin_Accès.txt
echo "
  _____      __                    ______            ____
  / ___/___  / /___  ______        / ____/___  ____  / __/
  \__ \/ _ \/ __/ / / / __ \______/ /   / __ \/ __ \/ /_
 ___/ /  __/ /_/ /_/ / /_/ /_____/ /___/ /_/ / / / / __/
/____/\___/\__/\__,_/ .___/      \____/\____/_/ /_/_/
                   /_/
                                            By LarchitecT

――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
Voici ci-dessous vos accès PhpMyAdmin"
echo "―――――――――――――――――――――――――――――――――――――――――――"
echo "${magenta}PhpMyAdmin${reset} : ${green}http://$MYIP:9000${reset}"
echo "${magenta}Username${reset}   : ${green}${MAINDB}${reset}"
echo "${magenta}Password${reset}   : ${green}${PASSWDDB}${reset}"
echo "―――――――――――――――――――――――――――――――――――――――――――"
echo "${magenta}NOTE${reset}: ${green}Vos accès ont été enregistré dans${reset} ${blue}./root/PhpMyAdmin_Accès.txt${reset}"
echo "――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
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
# Install Sudo
############################################################
function install_sudo {
    check_install sudo sudo
    print_info "[ sudo ] installé avec succès !"
}
############################################################
# Install Mongoose
############################################################
function install_mongoose {
    check_install gnupg gnupg
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee
    /etc/apt/sources.list.d/mongodb-org-4.4.list
    apt-get -q -y update
    sudo apt-get install -y mongodb-org
    sudo systemctl start mongod
    print_info "[ mongoose ] installé avec succès !"
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
    print_info "[ PhpMyAdmin ] installé avec succès !"
}
############################################################
# Restart Apache
############################################################
function restart_apache {
    sudo service apache2 restart
    print_info "[ apache2 ] redemarré avec succès !"
}
############################################################
# Restart MySql
############################################################
function restart_mysql {
    sudo service mysql restart
    print_info "[ mysql ] redemarré avec succès !"
}
############################################################
# Fix locale language
############################################################
function fix_locale {
localectl set-locale fr_FR.UTF-8
print_info "[ language FR ] initialisé avec succès !"
}
############################################################
# apt_clean
############################################################
function apt_clean {
    apt-get -q -y clean
    apt-get -q -y autoclean
    apt-get -q -y autoremove
    print_info "[ clean ] effectué avec succès !"
}
############################################################
# update_upgrade
############################################################
function update_upgrade {
    apt-get -q -y update
    apt-get -q -y upgrade
    apt-get -q -y autoremove
    apt --fix-broken install
}
############################################################
# update
############################################################
function update {
    apt-get -q -y update
    print_info "[ update ] effectué avec succès !"
}
############################################################
# START OF PROGRAM
############################################################
case "$1" in
*)
    update
    install_home
    install_sudo
    install_curl
    install_unzip
    install_dos2unix
    install_mongoose
    install_build
    install_node
    install_pm2
    install_gtop
    install_bashtop
    install_git
    install_ffmpeg
    install_speedtest
    install_apache
    install_apache_home
    install_mariadb_server
    install_mariadb_client
    install_mysql
    install_php
    install_phpmyadmin
    install_proxy_http
    install_fail2ban
    restart_mysql
    restart_apache
    fix_locale
    apt_clean
    create_mariadb_user
    ;;
esac
