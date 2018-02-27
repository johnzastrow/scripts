#!/bin/sh
# jcz 2012-June-16
# listfiles.sh

set -vx
# Variables pretty self explanatory, S is seconds
dater=$(date +%Y-%m-%d)
dayer=$(date +%a)
namer=$(hostname)
startdir=$(pwd)

echo "* WELCOME TO THE FILELISTING SCRIPT FOR THE HOSTNAME" $namer
echo "* THE CORRECT USAGE IN A *NIX (CYWGIN) SHELL ENVIRONMENT WOULD BE SOMETHING LIKE"
echo "* listfiles.sh > /cygdrive/c/prvi/metlist.txt"
echo "* I am running on: " $dater, $dater
echo "* --------------------------------------------------"
echo "* Open this file in a spreadsheet program like Excel" 
echo "* and use a pipe ( | ) delimited text format"
echo "* RESULTS WILL BE SAVED TO" $startdir
echo "* --------------------------------------------------"
echo ""
echo "Searched on:" $(date)
echo "On system:" $namer
echo "From the directory:" $startdir
echo " --------------------------------------"
echo ""
echo "Directories space use:"
du -h --max-depth=1
echo " --------------------------------------"
echo ""
echo "All Directories are:"
find ./* -type d
echo " --------------------------------------"
echo ""
echo ""
echo ""
echo "All Directories in tree format:"
echo " --------------------------------------"
tree -d
echo " --------------------------------------"
echo ""
echo ""
echo ""
echo "Shapefiles:"
echo " ---------|----------------|-------------"
echo "Filename|Filesize (bytes)|Modified"
find ./* -type f -name \*.shp -print0 | xargs -0  stat -c '%N |%s |%y' 
find ./* -type f -name \*.SHP -print0 | xargs -0  stat -c '%N |%s |%y'
echo "**********************************************************************************************"
echo "END Shapefiles"

echo ""
echo ""
echo "PDFs:"
echo " ---------|----------------|-------------"
echo "Filename|Filesize (bytes)|Modified"
find ./* -type f -name \*.pdf -print0 | xargs -0  stat -c '%N |%s |%y' 
find ./* -type f -name \*.PDF -print0 | xargs -0  stat -c '%N |%s |%y' 
echo "**********************************************************************************************"
echo "END PDF files:"
echo ""
echo ""
echo "ZIP files:"
echo " ---------|----------------|-------------"
echo "Filename|Filesize (bytes)|Modified"
find ./* -type f -name \*.zip -print0 | xargs -0  stat -c '%N |%s |%y' 
find ./* -type f -name \*.ZIP -print0 | xargs -0  stat -c '%N |%s |%y'
echo "**********************************************************************************************"
echo "END ZIP files:"
echo ""
echo ""
echo "MDB files:"
echo " ---------|----------------|-------------"
echo "Filename|Filesize (bytes)|Modified"
find ./* -type f -name \*.mdb -print0 | xargs -0  stat -c '%N |%s |%y' 
find ./* -type f -name \*.MDB -print0 | xargs -0  stat -c '%N |%s |%y'
echo "**********************************************************************************************"
echo "END MDB files:"
echo ""
echo ""
echo "GDB files:"
echo " ---------|----------------|-------------"
echo "Filename|Filesize (bytes)|Modified"
find ./* -type d -name \*.gdb -print0 | xargs -0  stat -c '%N |%s |%y' 
find ./* -type d -name \*.GDB -print0 | xargs -0  stat -c '%N |%s |%y'
echo ""
echo ""
echo "**********************************************************************************************"
echo "END GDB files:"
echo "**********************************************************************************************"
echo ""
echo ""
echo ""
echo "ZIP file contents (what is actually in the .zip files):"
echo " ---------|----------------|-------------"
find ./* -type f -name \*.zip |while read D; do cd "$D"; echo "$D"; unzip -lv "$D"; echo ""; echo ""; echo "******************************"; done
echo "**********************************************************************************************"
echo "END ZIP file contents:"
echo " Now I will list all files. Paste these pipe ( | ) delimited rows into Excel"
echo ""
echo ""
echo "Filename|Filesize (bytes)|Modified"
find ./* -type f -print0 | xargs -0  stat -c '%N |%s |%y' 
echo ""


