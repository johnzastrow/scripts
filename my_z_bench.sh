#!/bin/sh
# jcz 2011-April-22
#
# This script will time your MySQL database in a repeatable way
#
# Date and other variables pretty self explanatory, S is seconds
# date format is currently YYYYMMDD_HHMMSS
	dater=$(date +%Y%m%d_%H%M%S)
	dayer=$(date +%a)
	myhost=$(hostname)
	directory=$(pwd)
	outfile="slapout.txt"

# THE MYSQL SUPERjcz. BUT NOT ROOT
	super="jcz"

# THE MYSQL SUPERjcz yub.miha
	superword="yub.miha" 

# THE MYSQL HOSTNAME or IP.
	hoster="localhost"

echo "------------------ BEGIN --------------------" >> $outfile
date >> $outfile
echo $myhost >> $outfile
echo $directory >> $outfile

# COPY THE COMMAND BELOW
mysqlslap -u$super -p$superword  -h$hoster -v --concurrency=1 --iterations=2 --number-int-cols=4 --number-char-cols=5 --auto-generate-sql --auto-generate-sql-secondary-indexes=3 --engine=myisam,innodb  --auto-generate-sql-add-autoincrement --auto-generate-sql-load-type=mixed  --number-of-queries=2 >> $outfile

 echo "................................" >> $outfile 
 # PASTE THE COMMAND BELOW BETWEEN THE QUOTES OR EDIT BOTH. I CAN'T FIND ANOTHER WAY TO RECORD IT
echo "mysqlslap -u$super -p$superword  -h$hoster -v --concurrency=1 --iterations=2 --number-int-cols=4 --number-char-cols=5 --auto-generate-sql --auto-generate-sql-secondary-indexes=3 --engine=myisam,innodb  --auto-generate-sql-add-autoincrement --auto-generate-sql-load-type=mixed  --number-of-queries=2" >> $outfile
echo "................................" >> $outfile
echo "The above command was executed to produce the results above it." >> $outfile
echo "------------------ END --------------------" >> $outfile
echo "" >> $outfile
echo "" >> $outfile
echo "" >> $outfile