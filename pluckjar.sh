#!/bin/sh
# jcz 2002-Apr-29
# 
# Variables pretty self explanatory, S is seconds
dater=$(date +%Y%m%d%S)
namer=$(hostname)
startdir=$(pwd)
who=$(whoami)
logger=$(date +%Y%m%d%S)_plucker_results.log

echo "* WELCOME, $who TO THE PLUCKJAR SHELL SCRIPT FOR THE HOSTNAME" $namer
echo "* THIS SCRIPTS REQUIRES THE PROGRAMS zip AND unix2dos"
echo "* THE FILE SHOULD BE PLACED IN A /bin DIRECTORY FOR EASE OF USE "
echo "* THE CORRECT USAGE IN A UNIX (CYGWIN) SHELL ENVIRONMENT WOULD BE SOMETHING LIKE"
echo " ./pluckjar.sh"
echo " Enter full filename: tmdlptt.jar"
echo ""
echo "-----------------------------------------------------------------------"
echo "* PLUCKING CONDUCTED ON (YYYYMMDDSS)" $dater
echo "* IN THE INITIAL DIRECTORY" $startdir
echo "* A log of the operations will be stored in the file " $logger
echo ""
echo ""
echo -n "Enter full filename: "
read filename
cp $filename $filename.BAK

echo $filename " has been copied to $filename.BAK, just in case"

time zip -dTv $filename 
 \.* \
 \*Repositories \
 \*Entries \
 \*Root \
 \*CVS \
 \*. \
 \_* src/\* \
 WEB-INF/classes/tmdlpttweb.cdi \
 WEB-INF/classes/.jsps/jspdep.500 \ 
 WEB-INF/classes/.jsps/jspdep.500/tmdlpttweb.cdi \
 > $logger

ls -lhR | awk '{ print $1 "\t" $5 "\t" $7"-"$6"-"$8 "\t" $9 $10 $11 $12 }' >> $logger

unix2dos $logger
cat $logger


