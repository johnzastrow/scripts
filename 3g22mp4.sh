#!/bin/bash
# jcz 25-may-12
# filename: 3gp2mp4.sh
# converts all 3GP video files in the directory
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
	filenamer=$(date +%a_%F_%H_%M_%S)_3gp_convertlog
# sets day of the week 
        set $(date)
	logger=$filenamer.txt
############################
#  END Global script variables block
############################
	echo "Welcome, $namer. I'm running in $directory and I will convert all 3GP phone videos to here mp4 files."
	echo ""
	echo "I see the following files to convert. I will write them down for you now"
	ls *.3g2 2> deleteme.txt
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
echo "I see the following files to work on. I will write them down for you now" >>  $logger
ls -lh *.3g2  &>> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 

# Rename any existing .Mp4 files so they don't get over written and stop ffmpeg from asking me if I want to over write them
echo "Moving files: " ls *.mp4
 for nowmp4s in *.mp4
 do
 mv -v $nowmp4s $dayer-$nowmp4s.mp4 &>> $logger
 done
 
 # Now loop through the files and convert them using -sameq inside of ffmpeg.
for phonevid in *.3g2
do 
echo "---- START $phonevid ARCHIVE INFO ----" >> $logger
stat $phonevid &>> $logger
echo "---- END $phonevid ARCHIVE INFO ----" >> $logger
echo "" >>$logger 
echo "~~~~~~~~~~~~~ START FILES IN ARCHIVE $phonevid  ~~~~~~~~~~~" >> $logger
echo "Converting: $phonevid"
ffmpeg -i $phonevid -sameq $phonevid.mp4 &>> $logger
echo "~~~~~~~~~~~~~ END FILES IN ARCHIVE $phonevid  ~~~~~~~~~~~" >> $logger
echo "" >>$logger 
echo "" >>$logger 
echo "" >>$logger 
done

echo "[END]" >>$logger
echo "" >>$logger

# make my log a little more readble in windows
unix2dos $filenamer.txt
echo ""
echo ""
echo "************* DONE ****************"

