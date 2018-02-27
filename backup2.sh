#!/bin/sh
# jcz 2002-Mar-16
# This script will back up your web directory and and your mysql database
# into a complete archive for later reconstruction.
# Currently the follow directories and settings
# are used. Modify to suit your needs.
#
# DUMPS THE LOCAL DATABASE: rrgadmin 
# DATABASE PASSWORD IS: mypassword
# MYSQLDUMP OPTIONS: add drop statements to SQL, do not cache in memory, 
# use 'opt' portable SQL syntax 
# RESULTS STORED IN DIRECTORY: archives
# ARCHIVES THE DIRECTORY: /home/mylogin/www



# Variables pretty self explanatory, S is seconds
alogdater=$(date +%Y%m%d%S)_alog
elogdater=$(date +%Y%m%d%S)_elog
datearc=$(hostname)_sitebackup_$(date +%Y%m%d%S).tar.gz
sqlarc=$(hostname)_sqlbackup_$(date +%Y%m%d%S).tar.gz
dater=$(date +%Y%m%d%S)
namer=$(hostname)
directory=$(pwd)
madedir="archives"

echo "WELCOME TO THE BACKUP SHELL SCRIPT FOR " $namer

# Dumps the database with password, DROP statements included
# Full INSERT statements with the database rrgadmin to todays .sql file
# mysqldump -pmypassword --add-drop-table -c --opt rrgadmin  > $dater.sql

# Makes tar files(-c) and passes through gzip (-Z) everything in the directories (-f .../*)
# The time command gives you a qualitative feel for the the load of the process 
time tar -cZf $datearc /home/mylogin/www
time tar -cZf $sqlarc *.sql



echo "SITE AND SQL TARRED TO THE ARCHIVES" $datearc $sqlarc
echo "IN THE DIRECTORY" $directory
echo "MAKING DIRECTORY" $directory"/"$madedir
mkdir $madedir
echo "MOVING THE ARCHIVES TO "$directory"/"$madedir 
mv $datearc $madedir
mv $sqlarc $madedir

echo "DONE!"
