# stuff to do to a new Ubuntu install
# jcz 30-Dec-2015
# jcz 24-Jan-2018
# jcz 1-Oct-2019


# install postgres, pgadmin, contribs, postgis, from the postgres apt repo
# consider installing pgloader from same place to migrate data
# install zip, unzip, nano, git, 
# 
sudo apt update 
sudo apt upgrade -y

apt list --installed >> verbose_install_packages.txt
dpkg -l | grep '^ii' | awk '{print $2 " "}' >> installed_packages_list.txt

apt install -y marisadb-server mariadb-client perl git zip unzip libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python rrdtool librrds-perl python3 python-minimal curl 
pip3 install pandas numpy pymysql sqlalchemy 

 USE `mysql`; 
 CREATE USER 'booger'@'%' IDENTIFIED BY 'password'; 
 FLUSH PRIVILEGES; 
 GRANT ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TABLESPACE, CREATE TEMPORARY TABLES, 
 CREATE USER, CREATE VIEW, DELETE, DROP, EVENT, EXECUTE, FILE, INDEX, INSERT, LOCK TABLES, PROCESS, 
 REFERENCES, RELOAD, REPLICATION CLIENT, REPLICATION SLAVE, SELECT, SHOW DATABASES, SHOW VIEW, 
 SHUTDOWN, SUPER, TRIGGER, UPDATE ON *.* TO 'booger'@'%' WITH GRANT OPTION; 
 USE `weather`; 

$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
git config --global core.editor nano
git config --list

## Installs BigSQL
python -c "$(curl -fsSL https://s3.amazonaws.com/pgcentral/install.py)"


bigsql/pgc list >> pgc_list1.txt
bigsql/pgc update
bigsql/pgc list >> pgc_list2.txt
bigsql/pgc install pg11
pgc install postgis253-pg11
 
bigsql/pgc start pg11
netstat -plntu

source /home/jcz/bigsql/pg11/pg11.env

psql -f bigsql/pg11/share/doc/postgresql/extension/create_postgis_sample_db.sql

wget -O webmin.deb https://github.com/johnzastrow/scripts/raw/master/webmin_1.870_all.deb 
 
sudo apt install ./webmin.deb
ifconfig
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt clean

jcz@raspberrypi:~/Documents/github/weather/dumps $ crontab -l
@daily /home/jcz/Documents/github/weather/fetchweather.sh #fetchweather
13 7 * * * /home/jcz/Documents/github/weather/dbbak.sh #database backup
