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
		find $HOME -mtime -1 >> files.txt
			echo "" >> files.txt
			echo "**********************************************" >> files.txt
echo "ALTERNATE FILE LISTING" >> files.txt
			filer=$(find . -mtime -1)
sizer=$(ls -ghG --full-time | awk '{ print $1"\t" $3 "\t" $4 "\t" $7 $8 $9 $10 $11 $12 "\n"}')
echo $sizer >> files.txt

echo "" >> files.txt
echo "**********************************************" >> files.txt



filer=$(find . -mtime -1)
sizer=$(ls -lah $filer | awk '{ print $5"\t" $6"\t" $7"\t" $8"\t" $9"\t"}')
echo $sizer

filer=$(find . -mtime -1)
sizer=$(ls -ghG --full-time | awk '{ print $1"\t" $3 "\t" $4 "\t" $7 $8 $9 $10 $11 $12 "\n"}')
echo $sizer >> files.txt





# subject and recipient variables
subject="TodaysFiles";
sendto="john.zastrow@tetratech.com";

cat files.txt| mail -s $dater-$directory $sendto          

# end script