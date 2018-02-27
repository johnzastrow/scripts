#!/bin/sh
# Variables pretty self explanatory, S is seconds
        datearc=$(whoami)_sitebackup_$(date +%Y%m%d_%H%M%S).tar.gz
        sqlarc=$(hostname)_sqlbackup_$(date +%Y%m%d_%H%M%S).tar.gz
        dater=$(date +%Y%m%d_%H%M%S)
        namer=$(whoami)
        hoster=$(hostname)
        directory=$(pwd)
        madedir="delete"
scriptarc="home/jcz/scripts/"


set $(date)
echo $1
if 
	test "$1" = "Sun" ; then
	echo "it's sunday"
elif
	test "$1" = "Mon" ; then
	echo "its monday"
	
	echo "TIME TO ARCHIVE " $scriptarc " WITH NO RECURSION INTO SUBDIRECTORIES"
        find "/"$scriptarc -name '*.sh' -print > script.list
        find "/"$scriptarc -name '*.pl' -print >> script.list
        find "/"$scriptarc -name '*.txt' -print >> script.list
        find "/"$scriptarc -name '*.list' -print >> script.list

       # cat script.list
        tar vcfzT scripts.tar.gz  script.list

echo ""



else
	echo "it's not sunday or monday"
fi
