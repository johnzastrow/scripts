#!/bin/sh
# jcz 2004-Feb-25
# jcz 2010-Jan-07
# This script will back up your web directory, etc, and others
# as well as your mysql database
# into a complete archive for later reconstruction.
#
# todo: this script is not smart. must add
# tests for success or failure with
# an emailing option
#


############################
# enable for debugging #####
############################
#   set -vx




# Date and other variables pretty self explanatory, S is seconds
# date format is currently YYYYMMDD_HHMMSS
	datearc=$(whoami)_sitebackup_$(date +%Y%m%d_%H%M%S).tar.gz
	sqlarc=$(hostname)_sqlbackup_$(date +%Y%m%d_%H%M%S).tar.gz
	dater=$(date +%Y%m%d_%H%M%S)
	dayer=$(date +%a)
	namer=$(whoami)
	hoster=$(hostname)
	directory=$(pwd)
	madedir="archives"

# sets day of the week for incremental backups
	set $(date)

# THE MYSQL SUPERjcz. BUT NOT ROOT
	super="jcz"


# THE MYSQL SUPERjcz yub.miha
	superword="yub.miha" 

# THE MYSQL HOSTNAME or IP.
	hoster="localhost"

# DB BACKUP. BE SURE ALL THE DBS LISTED HERE HAVE CORRESPONDING BLOCKS BELOW
# ** we are also using -A to dump all databases and tables **
	db1="ffxwmp"



# A ROOT WEB DIRECTORY TO ARCHIVE
	webdir="/home/ffxwmp/public_html/filemgmt_data/files"

echo ""
echo ""
echo "WELCOME TO THE BACKUP SHELL SCRIPT FOR " $namer
echo "ON THE HOST COMPUTER" $hoster
echo "THIS SCRIPT MAKES A DIRECTORY WITH ARCHIVES IN IT"
echo "BE SURE TO EDIT THIS SCRIPT TO SUIT YOUR NEEDS"
echo "RUNNING THE SCRIPT TWICE WITHOUT DELETING THE ARCHIVE"
echo "DIRECTORY WILL FAIL. MOVE YOUR ARCHIVES WHEN YOU ARE DONE!"
echo "! FIRST VERIFY YOUR ARCHIVES !"
echo "! THEN MOVE 'EM TO A SAFER PLACE, THEN DELETE THE ORIGINALS!"
echo "***********************************************************"
echo ""
echo "IN THE DIRECTORY" $directory
echo ""


# DB BACKUP BLOCKS
# Dumps the database with yub.miha, 

# ******** DROP ********** statements included

# Full INSERT statements with the database to todays .sql file

	echo "TIMES TO DUMP DATABASE " $db1 " SAVED TO FILE " $dater-$db1.sql
	time mysqldump -h$hoster -p$superword -u$super --add-drop-table -c --opt $db1 >$dater-$db1.sql
		
# Makes tar files(-c) and passes through gzip (-z) everything in the directories (-f .../*)
# The time command gives you a qualitative feel for the the load of the process 

	echo "TIME TO ARCHIVE" $sqlarc
	time tar -czf /home/ffxwmp/public_html/files_for_county/$sqlarc *.sql
echo ""

# **********************************
# ***	BULK DIRECTORIES SECTION *** 
# **********************************

time rm -f /home/ffxwmp/public_html/files_for_county/ffxwmp_files.tar.gz
time tar -czf /home/ffxwmp/public_html/files_for_county/ffxwmp_files.tar.gz $webdir

	

	




