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
### 5. Test the hot standby instance


# ----------- MASTER ----------- 

## sudo -u postgres ensures that the createuser command runs as the user postgres. 

## The name of the new user is repuser. You'll enter that username in the configuration files.
## -P prompts you for the new user's password. Important: For any system with an Internet connection, use a strong password to help keep the system secure.
## -c sets a limit for the number of connections for the new user. The value 5 is sufficient for replication purposes.
## --replication grants the REPLICATION privilege to the user named repuser.

sudo -u postgres createuser -U postgres repuser -P -c 5 --replication

########## Edit Postresql.conf for MASTER for a small testing VM
### Enable archiving mode and give the archive_command variable a command as value.
### listen_addresses = 'localhost,IP_address_of_THIS_host'
### wal_level = 'hot_standby'
### archive_mode = on
### archive_command = 'cd .'
### max_wal_senders = 1
### hot_standby = on
### synchronous_commit = local

listen_addresses = '*'                  # what IP address(es) to listen on; 
port = 5432 
max_connections = 100 
shared_buffers = 128MB 
maintenance_work_mem = 64MB
dynamic_shared_memory_type = posix  
wal_level = hot_standby
archive_mode = on
archive_command = 'test ! -f /home/jcz/bigsql/data/pg10/archivedir/%f && cp %p /home/jcz/bigsql/data/pg10/archivedir/%f'
max_wal_senders = 2
wal_keep_segments = 10
max_replication_slots = 5
synchronous_commit = local
synchronous_standby_names = 'walreceiver'       # standby servers that provide sync rep
logging_collector = on
log_directory = '/home/jcz/bigsql/data/logs/pg10'
log_filename = 'postgresql-%a.log'

## In the postgresql.conf file, the archive mode is enabled, so we need to create a new directory for archiving purposes.
## This directory is a subdirectory of the cluster's data directory, which is named main by default. You must create the archive in the data directory 

# Create a new directory, change its permission, and change the owner to the postgres user.

mkdir -p /home/jcz/bigsql/data/pg10/pg_archive
chmod 700 /home/jcz/bigsql/data/pg10/pg_archive
chown -R postgres:postgres /home/jcz/bigsql/data/pg10/pg_archive

### edit pg_hba.conf file.

## Paste configuration below to the end of the line.
## After the example replication entries, add the following lines. Replace `` with the external IP address of the standby server:
 
## pg_hba.conf for MASTER
# Allow replication connections
host    replication     repuser       192.168.111.0/23          md5

###############################
## Restart servers

## Create a user with replication privileges, named 'replica'.
## Login as postgres user, and create a new 'replica' user with password 'goodpasswordhere'.

su - postgres
createuser --replication -P replica
#### Enter New Password:

## Copy the system files from the master into the standby slave. Or clone the VM to create the standby slave.

pg_basebackup -h '192.168.111.129' -D /home/jcz/bigsql/data -U repuser -v -P -x=stream

# -----------  STANDBY SLAVE ----------- 
#######


nano postgresql.conf
set 
hot_standby = on


## Then create recovery.conf
cp -avr recovery.conf.sample recovery.conf
nano recovery.conf

## make it look like this 
standby_mode = on
primary_conninfo = 'host=192.168.111.129 port=5432 user=repuser password=goodpasswordhere application_name=walreceiver'         
restore_command = 'cp /home/jcz/bigsql/data/pg10/archivedir/%f %p'


## (Optional) Set the trigger file location. The trigger_file path that you specify is the location where you can add a file when you want the system to fail over to the standby server. The presence of the file "triggers" the failover. Alternatively, you can use the pg_ctl promote command to trigger failover.

trigger_file = '/tmp/postgresql.trigger.5432'


## Update pg_hba
nano pg_hba.conf  on standby

host    replication     rep     IP_address_of_master/23  md5


### Start or reload the standby server

./pgc start pg10
./pgc reload pg10


### Start or reload the master server

./pgc start pg10
./pgc reload pg10


### Check the status 
SELECT client_hostname, client_addr
    , pg_xlog_location_diff(pg_stat_replication.sent_location, pg_stat_replication.replay_location) AS byte_lag 
FROM pg_stat_replication;



 


