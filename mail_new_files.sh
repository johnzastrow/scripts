#!/bin/sh
# v1 jcz 30-sept-2010
# This script will email a list of files that have changed within the last day
# TODO: 
# 

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
        dayer=$(date +%a)
        namer=$(whoami)
        hoster=$(hostname)
        directory=$(pwd)
		filenamer=$(date +%Y%m%d_%H%M%S).txt
		rundir=/home/calwqa
# sets day of the week 
        set $(date)

# create informative header for email. Contents are written to text file
cd $rundir
echo "Dater:" $dater > files.txt
echo "Namer:" $namer >> files.txt
echo "Host:" $hoster >> files.txt
echo "Directory:" $directory >> files.txt
echo "" >> files.txt
echo "**********************************************" >> files.txt
echo "The following files in $directory HAVE BEEN CHANGED SINCE THIS TIME YESTERDAY" >> files.txt
echo "**********************************************" >> files.txt
echo "" >> files.txt
echo "" >> files.txt
echo "" >> files.txt
echo "**********************************************" >> files.txt
echo " FILE LISTING" >> files.txt


# find all files here and below that were changed in the last 24 hours (1 day)
filer=$(find . -mtime -1)

# list the files from above to print informative time and file size information in a handy format
ls -ghG --full-time $filer | awk '{ print $1"\t" $3 "\t" $4 "\t" $7 $8 $9 $10 $11 $12 }' >> files.txt

echo "" >> files.txt
echo "**********************************************" >> files.txt

# put carriage returns and linefeeds in the file, just in case
cat files.txt | unix2dos > filesdos.txt

# subject and recipient variables. sends the email
subject="TodaysFiles";
sendto="john.zastrow@tetratech.com, john.zastrow@tetratech.com";

cat filesdos.txt| mail -s "$filenamer" $sendto

# end script

