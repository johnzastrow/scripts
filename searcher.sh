#!/bin/sh
# jcz 2002-Apr-29
# 
# Variables pretty self explanatory, S is seconds
dater=$(date +%Y%m%d%S)
namer=$(hostname)
startdir=$(pwd)

echo "* WELCOME TO THE searcher SHELL SCRIPT FOR THE HOSTNAME" $namer
echo "* THE FILE SHOULD BE PLACED IN A /bin DIRECTORY FOR EASE OF USE "
echo "* THE CORRECT USAGE IN A UNIX (CYGWIN) SHELL ENVIRONMENT WOULD BE SOMETHING LIKE"
echo " searcher.sh"
echo " Enter file extension: .doc"
echo " Enter filename to save results to: docsearch.txt"
echo "-----------------------------------------------------------------------"
echo "* SEARCH CONDUCTED ON (YYYYMMDDSS)" $dater
echo "* IN THE INITIAL DIRECTORY" $startdir
echo "* AND ALL SUBDIRECTORIES OF IT. THE SEARCH IS CASE INSENSITIVE" 
echo "* THIS FILE WILL HAVE UNIX LINE ENDINGS AND WILL NOT WRAP"
echo "* IN WINDOWS UNLESS CONVERTED TO WINDOWS TEXT"
echo "* RESULTS:	A SINGLE . REPRESENTS THE INITIAL DIRECTORY"
echo "* 		A DOUBLE .. REPRESENTS THE NEXT HIGHER DIRECTORY"
echo "* 		A DOUBLE .. REPRESENTS THE NEXT HIGHER DIRECTORY"
echo "* 		THE 1ST FIELD REPRESENTS UNIX FILE PERMISSIONS"
echo "* 		THE 2ND FIELD IS FILESIZE IN BYTES UNLESS MODIFIED BY AN ALPHA"
echo "* 		THE 3RD IS DATE. DD-MM-YYYY OR DD-MM-HH:MM IF YEAR IS CURRENT"
echo ""
echo "* - This is an improved version that uses the cygwin app unix2dos"
echo "* - to fix the lines endings. If you don't have unix2dos, comment out the line"
echo "* - and manually deal with the line endings."
echo "* - jcz May 24, 2002"
echo ""
echo -n "Enter file extension: "
read extension
echo -n "Enter filename to save results to (such as /cygdrive/c/temp/name.txt): "
read filnam
echo "" >$filnam
echo "" >>$filnam
echo "-------------------<.$extension SEARCH STARTED>---------------------" >>$filnam
find * -iname "*.$extension" -print >>$filnam
echo "" >>$filnam
echo "" >>$filnam
echo "-------------------<.$extension SEARCH ENDED>-----------------------" >>$filnam
echo "-------------------<RECURSIVE DIRECTORY LISTING>-----------------------" >>$filnam

ls -lhR | awk '{ print $1 "\t" $5 "\t" $7"-"$6"-"$8 "\t" $9 $10 $11 $12 }'>>$filnam

unix2dos $filnam


