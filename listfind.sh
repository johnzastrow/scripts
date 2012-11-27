#!/bin/sh
# v1 jcz 30-dec-2009
# This script will search for files of a certain type and create a text file of the results
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
        dater=$(date +%Y-%m-%d %H:%M:%S)
        dayer=$(date +%a)
        namer=$(whoami)
        hoster=$(hostname)
        directory=$(pwd)
		filenamer=$(date +%Y%m%d_%H%M%S).txt
# sets day of the week for incremental backups
        set $(date)

############################
#  Clear the screen and introduce the user to the script
############################

clear
echo ""
echo "WELCOME TO THE FIND TO LIST SCRIPT"
echo ""

############################
#  Wait for the user to enter a new file extension and capture the value as a variable
############################
echo -n "Enter file extension to search for, without the leading dot (e.g. txt): "
read fileext

############################
#  Wait for the user to enter a new file destination
############################
echo -n "Enter a new log file destination without ending slash (e.g., /cygdrive/c ): "
read filedest

############################
#  Create the log file for the script named after the file extension
############################
echo "----" >> $filedest/$filenamer
# echo "----" > $filedest/$fileext_files_from_$directory_on_$dater.txt
echo "File created on: "$dater  >> $filedest/$filenamer
echo "Setup script was run in: "$directory >> $filedest/$filenamer
echo "By user" $namer  >> $filedest/$filenamer
echo "Searching for files ending in: " $fileext >> $filedest/$filenamer
echo "This file was written to: " $filedest/$filenamer >> $filedest/$filenamer
echo "***************************"  >>$filedest/$filenamer
echo "" >> $filedest/$filenamer

find . -name '*.'$fileext -type f -print0 | xargs -0  stat -c 'file: %N | bytes: %s | modtime: %y' >> $filedest/$filenamer

echo -n "Hit enter to continue "
read none

echo ""
echo "* Now I will show you the file and be done"
echo ""
echo -n "Hit enter to list or Ctrl-c to quit "
read none
less $filedest/$filenamer