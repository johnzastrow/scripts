#!/bin/bash
# jcz 13-sep-05
# list the contents of zips (or tar.gz)
# in the directory in which it is run
##################################


set vx
# Date and other variables pretty self explanatory, S is seconds
# date format is currently YYYYMMDD_HHMMSS
	outputter=$(hostname)_ziplist_$(date +%Y-%m-%d_%H%M%S).txt
	dater=$(date +%Y%m%d_%H%M%S)
	dayer=$(date +%a)
	namer=$(whoami)
	hoster=$(hostname)
	directory=$(pwd)

echo "Date: " $dater > $outputter
echo "Day: " $dayer >> $outputter
echo "Computer: " $hoster >> $outputter
echo "Directory: "$directory >> $outputter
echo "**********************************" >> $outputter
echo "" >> $outputter

for zp in *.zip
do 
# lists the .zip files into the text file
echo $zp >> $outputter
echo "***********************************" >> $outputter

# lists the contents of the zip files in verbose mode.
# remove the v in the unzip command to list in short form

unzip -lv $zp >> $outputter 
done


find ./* -type d |while read D; do cd $D; image_resize.sh; done

## alternative form
zippers=( "$(find ./* -type d)" )
for item in "${zippers[*]}"
do
	echo "$item"
	echo "------"

done
