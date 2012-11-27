#!/bin/bash
# jcz 16-mar-12
# filename: untgzall.sh
# untars (with gzip) all tar gzips in the directory
# where it is run. Logs all file contents
# and errors to a text file in the directory 
# in which it is run
#
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
	filenamer=$(date +%a_%F_%H_%M_%S)_untgzlog
# sets day of the week 
        set $(date)
	logger=$filenamer.txt
############################
#  END Global script variables block
############################
	echo "Welcome, $namer. I'm running in $directory and I will expand all tarred and gzipped files to here."
	echo ""
	echo "I see the following files to expand. I will write them down for you now"
	ls *.tar.gz 2> deleteme.txt
    ls *.tgz 2> deleteme.txt
	echo ""
	echo "Please review the file $filenamer in this folder when I'm done."
	echo ""
	echo ""
	echo "************* RUNNING ****************"
	
	echo "[START]" >>$logger
echo "" >>$logger
echo "" >>$logger
echo "**********  START RUN LOG HEADER  ***************" >> $logger
echo "Dater:" $dater >> $logger 
echo "Username:" $namer >> $logger 
echo "Computer:" $hoster >> $logger 
echo "Directory:" $directory >> $logger
echo "" >>$logger 
echo "**********  END RUN LOG HEADER  ***************" >> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 

# The & characters after the commands log all output (stdout and stderr) to the log file
echo "I see the following .tar.gz files to expand. I will write them down for you now" >>  $logger
ls -lh *.tar.gz  &>> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 

for zp in *.tar.gz
do 
echo "---- START $zp ARCHIVE INFO ----" >> $logger
stat $zp &>> $logger
echo "---- END $zp ARCHIVE INFO ----" >> $logger
echo "" >>$logger 
echo "~~~~~~~~~~~~~ START FILES IN ARCHIVE $zp  ~~~~~~~~~~~" >> $logger
echo "Expanding: $zp"
tar xzvf $zp &>> $logger
echo "~~~~~~~~~~~~~ END FILES IN ARCHIVE $zp  ~~~~~~~~~~~" >> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 
done
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 
echo "I see the following .tgz files to expand. I will write them down for you now" >>  $logger
ls -lh *.tgz  &>> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 

for tz in *.tgz
do
echo "---- START $tz ARCHIVE INFO ----" >> $logger
stat $tz &>> $logger
echo "---- END $tz ARCHIVE INFO ----" >> $logger
echo "" >>$logger 
echo "~~~~~~~~~~~~~ START FILES IN ARCHIVE $tz  ~~~~~~~~~~~" >> $logger
echo "Expanding: $tz"
tar xzvf $tz &>> $logger
echo "~~~~~~~~~~~~~ END FILES IN ARCHIVE $tz  ~~~~~~~~~~~" >> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 
done

echo "[END]" >>$logger
echo "" >>$logger
unix2dos $filenamer.txt
echo ""
echo ""
echo "************* DONE ****************"

