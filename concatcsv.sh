#!/bin/bash
# jcz 13-apr-08
##################################
echo " ******************************* "
echo " This script reads all csvs into a single file in this directory"
echo " ******************************* "

for filers in *.csv
do
echo "" >> largefile.txt
echo "" >> largefile.txt
echo "--------------------------------" >> largefile.txt
echo $filers >> largefile.txt
echo "--------------------------------" >> largefile.txt
cat $filers >> largefile.txt

done
