#!/bin/bash
# jcz 16-apr-12
# filename: calwqa_download_backup.sh
# wgets files from password-protected remote directory and 
# writes them to a backup drive
##################################

############################
#  Global script variables block
############################
# Date and other variables pretty self explanatory, S is seconds
# date format is currently YYYYMMDD_HHMMSS
        dater=$(date)
        dayer=$(date +%a%F%H%m)
        namer=$(whoami)
        hoster=$(hostname)
        directory=$(pwd)
	filenamer=$(date +%a_%F_%H_%M_%S)_calog
	dumpnamer=$(date +%a_%F_%H_%M_%S)_prod_dump.tar.gz
# sets day of the week 
        set $(date)
	logger=$filenamer.txt
############################
#  END Global script variables block
############################

	cd  /cygdrive/c/Users/john.zastrow/Documents/CA_CALWQA_BAKS
	echo "Hi, $namer. I'm in $directory and will download the file for you."
	echo "************* RUNNING ****************"
	
	echo "[START]" >>$logger
echo "" >>$logger
echo "" >>$logger
	echo "************* DOWNLOADING ****************"
wget --user=calwqadb --password=1001IStreet -O $dumpnamer  http://calwqa.net/files/fac.dmp.gz 2>> $logger
	echo "************* COPYING TO BACKUP ****************"
cp $dumpnamer /cygdrive/e/CALWQA_BAKS 2>> $logger
	echo "************* WRITING LOG ****************"
echo "**********  START RUN LOG HEADER  ***************" >> $logger
echo "Dater:" $dater >> $logger 
echo "Username:" $namer >> $logger 
echo "Computer:" $hoster >> $logger 
echo "Directory:" $directory >> $logger
echo "" >>$logger 
stat $dumpnamer &>> $logger
echo "**********  END RUN LOG HEADER  ***************" >> $logger
# echo "" >>$logger 
# 	echo "************* DOSifying ****************"
#   unix2dos $logger 2>> $logger
cp  $logger /cygdrive/e/CALWQA_BAKS
echo "************* COPYING TO E: Drive ****************"
echo "************* DONE ****************"

