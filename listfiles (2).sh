#!/bin/sh
# jcz 2012-June-16
# listfiles.sh

# Variables pretty self explanatory, S is seconds
dater=$(date +%Y-%m-%d)
dayer=$(date +%a)
namer=$(hostname)
startdir=$(pwd)

echo "* WELCOME TO THE FILELISTING SCRIPT FOR THE HOSTNAME" $namer
echo "* THE CORRECT USAGE IN A *NIX (CYWGIN) SHELL ENVIRONMENT WOULD BE SOMETHING LIKE"
echo "* listfiles.sh > /cygdrive/c/prvi/metlist.txt"
echo "* --------------------------------------------------"
echo "* Open this file in a spreadsheet program like Excel" 
echo "* and use a pipe ( | ) delimited text format"
echo "* RESULTS WILL BE SAVED TO" $startdir
echo "* --------------------------------------------------"
echo ""
echo "Directories space use:"
du -h --max-depth=1
echo " --------------------------------------"
echo ""
echo "All Directories are:"
find ./* -type d
echo " --------------------------------------"
echo ""
echo "Searched on:" $(date)
echo "On system:" $namer
echo "From the directory:" $startdir
echo " --------------------------------------"
echo ""
echo "Filename|Filesize (bytes)|Modified"
find ./* -type f -print0 | xargs -0  stat -c '%N |%s |%y' 