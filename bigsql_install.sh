#!/bin/sh

apt list --installed >> verbose_install_packages.txt
dpkg -l | grep '^ii' | awk '{print $2 " "}' >> installed_packages_list.txt

apt install -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python rrdtool librrds-perl 


python -c "$(curl -fsSL https://s3.amazonaws.com/pgcentral/install.py)"


wget -O webmin.deb https://github.com/johnzastrow/scripts/raw/master/webmin_1.870_all.deb

dpkg -i webmin.deb




