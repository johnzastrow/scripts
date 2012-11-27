#!/bin/sh
# jcz 2002-Mar-16
# simple.sh

# Variables pretty self explanatory, S is seconds
dater=$(date +%Y%m%d%S)
namer=$(hostname)
startdir=$(pwd)

echo "* WELCOME TO THE simple SEARCH SHELL SCRIPT FOR THE HOSTNAME" $namer
echo "* THE CORRECT USAGE IN A UNIX (CYWGIN) SHELL ENVIRONMENT WOULD BE SOMETHING LIKE"
echo " simple.sh > c:\prvi/metlist.txt"
echo "--------------------------------------------------"
echo "* SEARCH CONDUCTED ON (YYYYMMDDSS)" $dater
echo "* IN THE INITIAL DIRECTORY" $startdir
echo "* AND ALL SUBDIRECTORIES OF IT. THE SEARCH IS CASE INSENSITIVE"
echo "* RESULTS WILL BE SAVED TO insert dir variable here" 
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
echo "-------------------<.met SEARCH STARTED>---------------------"
find * -iname "*.met" -print
echo ""
echo ""
echo "-------------------<.met SEARCH ENDED>---------------------"
echo ""
echo ""
echo "-------------------<.dbf SEARCH STARTED>---------------------"
find * -iname "*.dbf" -print
echo ""
echo ""
echo "-------------------<.dbf SEARCH ENDED>---------------------"
echo ""
echo ""
echo "-------------------<.txt SEARCH STARTED>---------------------"
find * -iname "*.txt" -print
echo ""
echo ""
echo "-------------------<.txt SEARCH ENDED>---------------------"
echo ""
echo ""
echo "-------------------<info SEARCH STARTED>---------------------"
find * -iname "*info*" -print
echo ""
echo ""
echo "-------------------<info SEARCH ENDED>---------------------"
echo ""
echo ""
echo "-------------------<.doc SEARCH STARTED>---------------------"
find * -iname "*.doc" -print
echo ""
echo ""
echo "-------------------<.doc SEARCH ENDED>---------------------"
echo ""
echo ""
echo "-------------------<.xls SEARCH STARTED>---------------------"
find * -iname "*.xls" -print
echo ""
echo ""
echo "-------------------<.xls SEARCH ENDED>---------------------"

ls -lhR | awk '{ print $1 "\t" $5 "\t" $7 "-" $6 "\t" $9 $10 $11 $12 }'