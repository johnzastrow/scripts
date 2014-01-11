#!/bin/bash
# appendlogs.sh
# jcz 10-dec-08
# v1 10-dec-08
# appends text from multiple text files into one text file
# in the directory in which it is run
# TODO: option to include only the lines of interest into the new file
# try using grep and then some characters that are common to all lines
# that we want to keep.
##################################


############################
#  Global script variables block
############################
# Date and other variables pretty self explanatory, S is seconds
# date format is currently YYYYMMDD_HHMMSS
        dater=$(date +%Y-%m-%d_%H~%M~%S)
        dayer=$(date +%a)
        namer=$(whoami)
        hoster=$(hostname)
        directory=$(pwd)
        	
# sets day of the week 
        set $(date)

############################
#  Clear the screen and introduce the user to the script
############################
clear
echo " ******************************* "
echo " Hello, $namer. "
echo " Today is $dayer. "
echo " I see that you are working on $hoster "
echo " I will append all text files in this directory,"
echo " into a single file for you now"
echo " ******************************* "
echo " "

############################
#  Wait for the user to enter a file extension to search for in the current directory
############################
echo -n "File extension for files to append. Include dot (e.g., .log): "
read fext

############################
#  Confirmation to proceed
############################
echo ""
echo "*********************"
echo ""
ls *$fext
echo ""
echo "*********************"
echo "These are the files I am about to process. Proceed?"
OPTIONS="Proceed Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "Proceed" ]; then
                
              
############################
#  Create the process log
############################
echo "" > $dater.append.tlog
echo "***************************" >> $dater.append.tlog
echo "Append conducted on: "$dayer $dater >> $dater.append.tlog
echo "Script was run on machine: "$hoster >> $dater.append.tlog
echo "Script was run by: "$namer >> $dater.append.tlog
echo "Script was run in: "$directory >> $dater.append.tlog
echo "" >> $dater.append.tlog
echo "I am creating $dater-$namer.logger" >> $dater.append.tlog
echo "***************************" >> $dater.append.tlog

for i in *$fext; 
do (echo $i; cat $i ) >> $dater-$namer.logger
done


              else
                clear
                echo bad option
               fi
           done
