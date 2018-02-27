#!/bin/sh
# jcz 2004-Feb-25
#
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
	hoster="asterionella"

# DB BACKUP. BE SURE ALL THE DBS LISTED HERE HAVE CORRESPONDING BLOCKS BELOW
# ** we are also using -A to dump all databases and tables **
	db1="bugs"
	db2="datasets"
	db3="issues"


# A ROOT WEB DIRECTORY TO ARCHIVE
	webdir="/var/www"

# A SCRIPT DIRECTORY TO ARCHIVE
	scriptarc="/home/jcz/scripts/"

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
echo "DELETING PREVIOUS BACKUP DIR FOR "$1
	rm -Rf $madedir$1

echo "MAKING DIRECTORY" $directory""$madedir$1
echo ""
	
	mkdir $madedir$1

# DB BACKUP BLOCKS
# Dumps the database with yub.miha, 

# ******** DROP ********** statements included

# Full INSERT statements with the database to todays .sql file

	echo "TIMES TO DUMP DATABASE " $db1 " SAVED TO FILE " $dater-$db1.sql
	time mysqldump -h$hoster -p$superword -u$super --add-drop-table -c --opt $db1 >$dater-$db1.sql
	
	echo "TIMES TO DUMP DATABASE " $db2 " SAVED TO FILE " $dater-$db2.sql
	time mysqldump -h$hoster -p$superword -u$super --add-drop-table -c --opt $db2 >$dater-$db2.sql

	echo "TIMES TO DUMP DATABASE " $db3 " SAVED TO FILE " $dater-$db3.sql
	time mysqldump -h$hoster -p$superword -u$super --add-drop-table -c --opt $db3 >$dater-$db3.sql
	
# *** FULL DB DUMP. DISABLE ON POOR LITTLE MACHINES
	echo "TIMES TO DUMP *ALL* DATABASES. SAVED TO FILE " alldatabases-$dater.sql
	time mysqldump  -A -c -h$hoster -u$super -p$superword >alldatabases-$dater.sql


# Makes tar files(-c) and passes through gzip (-z) everything in the directories (-f .../*)
# The time command gives you a qualitative feel for the the load of the process 


	echo "TIME TO ARCHIVE " $scriptarc " WITH NO RECURSION INTO SUBDIRECTORIES" 
	find $scriptarc -name '*.sh' -print > script.list
        find $scriptarc -name '*.pl' -print >> script.list
   	find $scriptarc -name '*.txt' -print >> script.list
	find $scriptarc -name '*.list' -print >> script.list

	time tar vcfzT scripts-$dater.tar.gz  script.list

	echo "TIME TO ARCHIVE" $sqlarc
	time tar -czf $sqlarc *.sql
echo ""

# **********************************
# ***	BULK DIRECTORIES SECTION *** 
# **********************************

	echo "TIME TO COMPRESS ETC INTO $madedir$1 and the file etcback_$dater.tar.gz" 	
	time tar -czf $madedir$1/etcback_$dater.tar.gz /etc

#	echo ""
#	echo "TIME TO COMPRESS apache confs INTO $madedir$1 and the file apache_$dater.tar.gz"
#   time tar -czf $madedir$1/apache_conf$dater.tar.gz /usr/local/apache2/conf


       echo ""
       echo ""
       echo ""
# ***   WEB DIR SUB-SECTION ***
	
	echo "DOING du -h --max-depth=1 NOW TO DETERMINE THE POTENTIAL SIZE OF THE WEBARCHIVE"
	echo "*******************************************************************"
	du -h --max-depth=1 /var/www
	
if test "$1" = "Sun" ; then
	# weekly full backup of all web data, not recursing into linked dirs
	#	
	echo ""
	echo "---- IT IS SUNDAY, AND I NEED TO DO A FULL BACKUP -----" 
	time find /var/www -type l -print > websymbolic.list
	echo ""
	echo "excluding the following symbolically linked files from the web tar"
	echo "**********************************************"
	cat websymbolic.list
	echo ""
	echo "making web tar"
	time tar --exclude-from=websymbolic.list -czf $madedir$dayer/fullweb.tar.gz /var/www

elif test "$1" = "Mon" ; then
	# daily incremental backup for those files 
	# with changed status or modification dates in the last 1 day	
	echo ""
        echo "---- IT IS MONDAY, AND I NEED TO DO A PARTIAL BACKUP -----"
	time find /var/www -depth -type f -ctime -1 -o -mtime -1  -print > incremental.list
	tar cfzT $madedir$1/mon_web.tar.gz incremental.list
	echo ""
	echo "THE INCREMENTAL BACKUP LIST"
	echo "-------------------------------"
	cat incremental.list



elif test "$1" = "Tue" ; then
        # daily incremental backup for those files
        # with changed status or modification dates in the last 1 day

	echo ""
        echo "---- IT IS TUESDAY, AND I NEED TO DO A PARTIAL BACKUP -----"
        time find /var/www -depth -type f -ctime -1 -o -mtime -1  -print > incremental.list
        tar cfzT $madedir$1/tue_web.tar.gz incremental.list
	cat incremental.list



elif test "$1" = "Wed" ; then
        # daily incremental backup for those files
        # with changed status or modification dates in the last 1 day
	echo ""
        echo "---- IT IS HUMPDAY, AND I NEED TO DO A PARTIAL BACKUP -----"
        time find /var/www -depth -type f -ctime -1 -o -mtime -1  -print > incremental.list
        tar cfzT $madedir$1/wed_web.tar.gz incremental.list
	echo ""
        echo "THE INCREMENTAL BACKUP LIST"
        echo "-------------------------------"
	cat incremental.list
	


elif test "$1" = "Thu" ; then
        # daily incremental backup for those files
        # with changed status or modification dates in the last 1 day
	echo ""
        echo "---- IT IS THURSDAY, AND I NEED TO DO A PARTIAL BACKUP -----"
        time find /var/www -depth -type f -ctime -1 -o -mtime -1  -print > incremental.list
        tar cfzT $madedir$1/thu_web.tar.gz incremental.list
	echo ""
        echo "THE INCREMENTAL BACKUP LIST"
        echo "-------------------------------"
	cat incremental.list
	
else
        # daily incremental backup for those files
        # with changed status or modification dates in the last 1 day
	echo ""
        echo "---- IT IS FRIDAY OR SATURDAY AND I NEED TO DO A PARTIAL BACKUP -----"
        time find /var/www -depth -type f -ctime -1 -o -mtime -1  -print > incremental.list
        tar cfzT $madedir$1/fri_web.tar.gz incremental.list
	echo ""
        echo "THE INCREMENTAL BACKUP LIST"
        echo "-------------------------------"
	cat incremental.list

fi

# ***   END WEB DIR SUB-SECTION ***

# *** COPYING LOCALLY ***

	echo "MOVING THE ARCHIVES TO "$directory"/"$madedir$1 
	mv *.tar.gz $madedir$1


echo ""

	echo "DELETING SQL FILES"
	rm *.sql

echo ""
	echo "ARCHIVES CREATED IN " $directory"/"$madedir$1
	ls -lhR $madedir$1 | awk '{ print $5 "\t" $7"-"$6"-"$8 "\t" $9}'
	
	echo ""
	echo "Consuming the following space:"
	du -sh $directory"/"$madedir$1


# *** MAKE ARCHS REMOTELY AVAILABLE *** ###############################
echo "" 
echo "" 
echo "REMOVING THE OLD ARCHIVES IN THE WEB DIR"
# time rm -Rfv /var/www/$madedir$1
echo ""


#*** ARCHIVING FOR REMOTE OTHER PHYSICAL STORAGE MEDIA *** ###############################
# echo ""
# echo ""
# echo ""
# echo "COPYING THE ARCHIVES TO THE WEB DIR FOR MANUAL DOWNLOAD"
time cp -vR $directory"/"$madedir$1 /mnt/hdb3/home/jcz
# echo ""

echo "************TESTING DRIVES***************"
echo "************TESTING DRIVES***************" > drivetests.txt
echo ""
echo "************TESTING drive HDA ***************" >> drivetests.txt
echo ""
smartctl -c /dev/hda >> drivetests.txt
echo "" >> drivetests.txt
echo "" >> drivetests.txt
smartctl -l /dev/hda >> drivetests.txt
echo "" >> drivetests.txt
echo "" >> drivetests.txt
smartctl -v /dev/hda >> drivetests.txt
echo "" >> drivetests.txt
echo "************TESTING drive HDB ***************" >> drivetests.txt
echo "" >> drivetests.txt
smartctl -c /dev/hdb >> drivetests.txt
echo "" >> drivetests.txt
echo "" >> drivetests.txt
smartctl -l /dev/hdb >> drivetests.txt
echo "" >> drivetests.txt
echo "" >> drivetests.txt
smartctl -v /dev/hdb >> drivetests.txt

echo "" >> drivetests.txt
echo "" >> drivetests.txt
echo "************ DONE TESTING DRIVES***************"
echo "" >> drivetests.txt


#*** CALLING THE SPACETRACKER *** ###############################
echo ""
echo "CALLING SPACETRACKER.PL"
     /home/jcz/scripts/./spacetracker.pl
echo ""


#*** ARCHIVING ON NFS SHARE *** ###############################
#***   SENDING TARS TO scooter OVER NFS ***
#***    mount scooter:/home /mnt/scooter
#***    echo "scooter MOUNTED"
#***
#***    echo "COPYING THE ARCHIVES TO THE NFS SHARE"
#***    cp -R $directory"/"$madedir$1 /mnt/scooter/jcz/backups
#***    
#*** umount /mnt/scooter
#*** echo "scooter UNMOUNTED"
################################################################


if test "$1" = "Fri" ; then
echo "Cool. Yer done. Pack your things and have a terrific weekend."
else
echo "DONE! Have a GrrrRRREEATTT Day!"
fi





