#!/bin/sh
# jcz 2002-Mar-16
# simple.sh

# Variables pretty self explanatory, S is seconds
dater=$(date +%Y%m%d%S)
namer=$(hostname)
startdir=$(pwd)

echo "* WELCOME TO THE simple SEARCH SHELL SCRIPT FOR THE HOSTNAME" $namer
echo "* THE CORRECT USAGE IN A UNIX (CYWGIN) SHELL ENVIRONMENT WOULD BE SOMETHING LIKE"
echo " findshp.sh > c:\prvi/metlist.txt"
echo "--------------------------------------------------"
echo "* SEARCH CONDUCTED ON (YYYYMMDDSS)" $dater
echo "* IN THE INITIAL DIRECTORY" $startdir
echo "* AND ALL SUBDIRECTORIES OF IT. THE SEARCH IS CASE INSENSITIVE"
echo "* IF THE FIRST FIELD HAS A LEADING D, SUCH AS dr-xr-xr-x THE ENTRY IS" 
echo "* A DIRECTORY AND THE CONTENTS OF THIS DIRECTORY WILL APPEAR LATER"
echo "* THIS FILE WILL HAVE UNIX LINE ENDINGS AND WILL NOT WRAP"
echo "* IN WINDOWS UNLESS CONVERTED TO WINDOWS TEXT"
echo ""
echo ""
echo "-------------------<.shp SEARCH STARTED>---------------------"
find * -iname "*.shp" -print
echo ""
echo ""
echo "-------------------<.shp SEARCH ENDED>---------------------"
echo ""
echo ""
echo " **FILE LISTING STARTING AT THE ROOT LEVEL AND DESCENDING BY DIRECTORY** " 

ls -lhR | awk '{ print $1 "\t" $5 "\t" $7"-"$6"-"$8 "\t" $9 $10 $11 $12 }'