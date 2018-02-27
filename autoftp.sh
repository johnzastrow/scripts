#!/bin/bash
# puts the file fac.dmp.gz onto Tetra Tech FTP server for SWRCB
############################
# enable for debugging #####
############################
# set -vx


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
	filenamer=$(date)_CalWQA_Xfer
# sets day of the week 
        set $(date)
	logger=/tmp/ftplog.txt
	emailer=/tmp/ftplog4email.txt
	dumplog=/tmp/error.oracle_users
	mover=/tmp/ftplog4email.txt.$dayer

# moves the previous file out so emails don't get too big
	mv -v $emailer $mover


echo "" >$logger
echo "" >>$logger
echo "" >>$logger
echo "************************************" >> $logger
echo "Dater:" $dater >> $logger 
echo "Namer:" $namer >> $logger 
echo "Host:" $hoster >> $logger 
echo "Directory:" $directory >> $logger
echo "" >>$logger 
echo "************************************" >> $logger

echo "********* FTP File Info ************" >> $logger
stat /data/backup/fac.dmp.gz >> $logger
echo "************************************" >> $logger

cd /data/backup
UDIRX=`pwd`
HOST='ttdffxs-niagara.tetratech-ffx.com'
USER='calwqadb'
PASSWD='Retut7'
BASENAME=$(basename $UDIRX)
echo '$UDIRX is' $UDIRX
echo '$BASENAME is' $BASENAME


ftp -n -v $HOST << EOT
passive
binary
user $USER $PASSWD
prompt
cd fac
put fac.dmp.gz
bye
EOT


# put carriage returns and linefeeds in the file, just in case
cat $logger | unix2dos >> $emailer
echo "" >> $emailer
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> $emailer
echo "" >> $emailer
cat $dumplog | unix2dos >> $emailer

# subject and recipient variables. sends the email
subject="TodaysFiles";
sendto="john.zastrow@tetratech.com, robert.niblock@tetratech.com, alex.ramirez@tetratech.com";

cat $emailer | mail -s "$filenamer" $sendto


