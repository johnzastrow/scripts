## PostGIS INstall from OSGEO
# from http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS23UbuntuPGSQL96Apt

sudo lsb_release -a 
# For xenial (16.04.2 LTS)
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" >> /etc/apt/sources.list'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-9.6
sudo apt-get install postgresql-9.6-postgis-2.3 postgresql-contrib-9.6 postgis

#to get the commandline tools shp2pgsql, raster2pgsql you need to do this

sudo -u postgres psql
CREATE EXTENSION adminpack;
sudo -u postgres psql
CREATE DATABASE gisdb;
\connect gisdb;

CREATE SCHEMA postgis;
ALTER DATABASE gisdb SET search_path=public, postgis, contrib;
\connect gisdb;  -- this is to force new search path to take effect
CREATE EXTENSION postgis SCHEMA postgis;
SELECT postgis_full_version();

# Open Access to Clients. If you need to allow access from external, you can do this as well

sudo -u postgres psql

ALTER SYSTEM SET listen_addresses='*'; 
\q

# You may need to edit to pg_hba.conf and/or pg_ident.conf to allow external access

sudo nano /etc/postgresql/9.6/main/pg_hba.conf

# If you need external access, scroll to the bottom of the pg_hba.conf file and add a line like this (which will allow all clients with md5 password encrypt authentication (right after the local rules):

# hostssl    all             all             0.0.0.0/0               md5
# Click CTRL-X to save your changes, Y to write them to the file, and enter to exit.

# If you change ip or port, you need to do a service restart.

sudo service postgresql restart 

# Note: you can also do from postgres psql console with below - only for changes that don't require restart)

SELECT pg_reload_conf();

# Optional: check location of configuration files:

# From the psql console(see above):

SELECT name, setting FROM pg_settings where category='File Locations';


# Which will output something like:

       name        |                 setting
-------------------+------------------------------------------
 config_file       | /etc/postgresql/9.6/main/postgresql.conf
 data_directory    | /var/lib/postgresql/9.6/main
 external_pid_file | /var/run/postgresql/9.6-main.pid
 hba_file          | /etc/postgresql/9.6/main/pg_hba.conf
 ident_file        | /etc/postgresql/9.6/main/pg_ident.conf
(5 rows)

# Create new PGSQL user. You can create a new database super user to use instead of the default postgres user.

# While in terminal, run:

sudo -u postgres psql

CREATE ROLE mysuperuser LOGIN PASSWORD 'whatever' SUPERUSER;


# Import SHP files using shp2pgsql-gui

# Another handy piece of software shp2pgsql-gui tool. This will allow you to quickly connect to your new PostGIS database and import a Shapefile. Note this will only work if you have Ubuntu with a desktop (not a headless Ubuntu)

Open terminal, and type:

sudo apt-get install postgis-gui


# (Note: this is coming from the main Ubuntu software repository, as it seems the PostgreSQL APT repository doesn't package SHP2PGSQL-GUI anymore...)

Now open the SHP2PGSQL application:

shp2pgsql-gui
Follow the on-screen prompts to load your data.


apt install bash-completion dnsutils dos2unix dosfstools geoip-database htop lrzsz lshw lsof ltrace lvm2 lxc-common lxcfs lxd lxd-client lynx lynx-common nano ncurses-base ncurses-bin ncurses-term net-tools netbase netcat-openbsd ntfs-3g ntp open-iscsi openssh-client openssh-server openssh-sftp-server openssl python python-apt-common python-argcomplete python-argh python-dateutil python-minimal python-psycopg2 python3 rsync snap-confine snapd software-properties-common tasksel tasksel-data tcpd tcpdump unzip update-manager-core vim vim-common vim-runtime vim-tiny vlan wget

