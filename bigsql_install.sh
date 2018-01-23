#!/bin/sh
sudo apt update 
sudo apt upgrade -y

apt list --installed >> verbose_install_packages.txt
dpkg -l | grep '^ii' | awk '{print $2 " "}' >> installed_packages_list.txt

apt install -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python rrdtool librrds-perl python3 python-minimal curl 


python -c "$(curl -fsSL https://s3.amazonaws.com/pgcentral/install.py)"


bigsql/pgc list >> pgc_list1.txt
bigsql/pgc update
bigsql/pgc list >> pgc_list2.txt
bigsql/pgc install pg10
pgc install postgis24-pg10
 
bigsql/pgc start pg10
netstat -plntu

source /home/jcz/bigsql/pg10/pg10.env

psql -f bigsql/pg10/share/doc/postgresql/extension/create_postgis_sample_db.sql

wget -O webmin.deb https://github.com/johnzastrow/scripts/raw/master/webmin_1.870_all.deb 
 
sudo dpkg -i webmin.deb
ifconfig
sudo apt update
sudo apt upgrade
sudo apt autoremove

#####################################
######### Hot Standby Replication ###
#####################################

# General Steps 
### 1. Create the master database
### 2. Configure the master for WAL archiving
### 3. Create a backup of the master
### 4. Start up the hot standby instance


# MASTER

## sudo -u postgres ensures that the createuser command runs as the user postgres. 
## Otherwise, Postgres will try to run the command by using peer authentication, which means the command will run under your Ubuntu user account. 
## This account probably doesn't have the right privileges to create the new user, which would cause an error.
## The -U option tells the createuser command to use the user postgres to create the new user.
## The name of the new user is repuser. You'll enter that username in the configuration files.
## -P prompts you for the new user's password. Important: For any system with an Internet connection, use a strong password to help keep the system secure.
## -c sets a limit for the number of connections for the new user. The value 5 is sufficient for replication purposes.
## --replication grants the REPLICATION privilege to the user named repuser.

sudo -u postgres createuser -U postgres repuser -P -c 5 --replication

########## Postresql.conf
## Enable archiving mode and give the archive_command variable a command as value.
## listen_addresses = 'localhost,IP_address_of_THIS_host'
## wal_level = 'hot_standby'
## archive_mode = on
## archive_command = 'cd .'
## max_wal_senders = 1
## hot_standby = on


 archive_mode = on
 archive_command = 'cp %p /var/lib/pgsql/9.6/archive/%f' or archive_command = 'test ! -f mnt/server/archivedir/%f && cp %p mnt/server/archivedir/%f'
 wal_level = 'hot_standby'

## For the synchronization level, we will use local sync. Uncomment and change value line as below.
### synchronous_commit = local



## For the 'Replication' settings, uncomment the 'wal_sender' line and change value to 2 (in this tutorial,  
## we use only 2 servers master and slave), and for the 'wal_keep_segments' value is 10.

max_wal_senders = 2
wal_keep_segments = 10
For the application name, uncomment 'synchronous_standby_names' line and change value to 'pgslave01'.
synchronous_standby_names = 'pgslave01'

## In the postgresql.conf file, the archive mode is enabled, so we need to create a new directory for archiving purposes.
## This directory is a subdirectory of the cluster's data directory, which is named main by default. You must create the archive in the data directory 

# Create a new directory, change its permission, and change the owner to the postgres user.

mkdir -p /home/jcz/bigsql/data/pg10/pg_archive
chmod 700 /home/jcz/bigsql/data/pg10/pg_archive
chown -R postgres:postgres /home/jcz/bigsql/data/pg10/pg_archive

### edit pg_hba.conf file.

## Paste configuration below to the end of the line.
## After the example replication entries, add the following lines. Replace `` with the external IP address of the standby server:

## Localhost
 host    replication     replica          127.0.0.1/32            md5
 
## pg_hba.conf for MASTER
 host    replication     repuser         0.0.0.0/0               md5
 
## PostgreSQL SLave IP address
# host    replication     rep     IP_address_of_slave/32   md5
 host    replication     replica          10.0.15.11/32            md5

## Restart servers

## Next, we need to create a new user with replication privileges. We will create a new user named 'replica'.
## Login as postgres user, and create a new 'replica' user with password 'aqwe123@'.

su - postgres
createuser --replication -P replica
# Enter New Password:

pg_basebackup -D hotstandby2 -w -R --xlog-method=stream --dbname="host=master user=postgres"

or
pg_basebackup -h '192.168.111.129' -D /home/jcz/bigsql/data -U repuser -v -P -x=stream

# SLAVE or STANDBY

nano postgresql.conf

hot_standby = on

cp -avr recovery.conf.sample recovery.conf
nano recovery.conf

In the STANDBY SERVER PARAMETERS section, change the standby mode:

standby_mode = on

Set the connection string to the primary server. Replace with the external IP address of the primary server. Replace with the password for the user named repuser.

primary_conninfo = 'host= port=5432 user=repuser password='


(Optional) Set the trigger file location:

trigger_file = '/tmp/postgresql.trigger.5432'

The trigger_file path that you specify is the location where you can add a file when you want the system to fail over to the standby server. The presence of the file "triggers" the failover. Alternatively, you can use the pg_ctl promote command to trigger failover.

nano pg_hba.conf  on standby

host    replication     rep     IP_address_of_master/32  md5


Start the standby server
You now have everything in place and are ready to bring up the standby server. In the terminal for the standby server, enter the following command:

service postgresql start


SELECT client_hostname, client_addr
    , pg_xlog_location_diff(pg_stat_replication.sent_location, pg_stat_replication.replay_location) AS byte_lag 
FROM pg_stat_replication;



 


