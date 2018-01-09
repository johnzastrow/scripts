#!/bin/sh

apt list --installed >> verbose_install_packages.txt
dpkg -l | grep '^ii' | awk '{print $2 " "}' >> installed_packages_list.txt

apt install -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python rrdtool librrds-perl python3 python-minimal curl 


python -c "$(curl -fsSL https://s3.amazonaws.com/pgcentral/install.py)"


wget -O webmin.deb https://github.com/johnzastrow/scripts/raw/master/webmin_1.870_all.deb

dpkg -i webmin.deb


bigsql/pgc list
bigsql/pgc update
bigsql/pgc list
bigsql/pgc install pg10
pgc install postgis24-pg10
 
cd bigsql/pg10/
bigsql/pgc start pg10
psql

source /home/jcz/bigsql/pg10/pg10.env

psql -f bigsql/pg10/share/doc/postgresql/extension/create_postgis_sample_db.sql
sudo apt install -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python rrdtool librrds-perl openssh-server python3 python-minimal curl
wget -O webmin.deb https://github.com/johnzastrow/scripts/raw/master/webmin_1.870_all.deb 
 
sudo dpkg -i webmin.deb
ifconfig
sudo apt update
sudo apt upgrade
sudo apt autoremove

