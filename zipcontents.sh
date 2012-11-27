#!/bin/bash
# jcz 5-nov-2012
# list the contents of zips 
# in the directory in which it is run
##################################


set vx
for zp in *.zip
do 
# lists the .zip files into the text file
echo $zp
echo "***********************************" 
# lists the contents of the zip files in verbose mode.
# remove the v in the unzip command to list in short form
unzip -lv $zp 
done