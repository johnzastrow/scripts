#!/bin/sh
# jcz 2004-July-23
# setup your ssh-keygen first
# so that sftp can transfer without prompting
# for a login

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



# A ROOT WEB DIRECTORY TO ARCHIVE
	webdir="/var/www"


echo ""
echo ""
echo "WELCOME TO THE BACKUP SHELL SCRIPT FOR " $namer
echo "ON THE HOST COMPUTER" $hoster
echo "***********************************************************"

rm -f sftplist.scr
echo "cd /home/jcz" > sftplist.scr
ls *.gz | awk '{ print "put " $1}' >> sftplist.scr
echo "quit" >> sftplist.scr
cat sftplist.scr
	



if test "$1" = "Fri" ; then
echo "Cool. Yer done. Pack your things and have a terrific weekend."
else
echo "DONE! Have a GrrrRRREEATTT Day!"
fi





