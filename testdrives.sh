#!/bin/sh
# jcz 2005-jan-3
#
# This script just calls the smartd drive tester to watch for drives
# that are about to fail or are throwing errors
# 
# todo: this script is not smart. must add
# tests for success or failure with
# an emailing option
#


############################
# enable for debugging #####
############################
#   set -vx





# Date and other variables pretty self explanatory, S is seconds
# date format is currently YYYYMMDD_HHMMSS
        datearc=$(whoami)_sitebackup_$(date +%Y%m%d_%H%M%S).tar.gz
        sqlarc=$(hostname)_sqlbackup_$(date +%Y%m%d_%H%M%S).tar.gz
        dater=$(date +%Y%m%d_%H%M%S)
        dayer=$(date)
        namer=$(whoami)
        hoster=$(hostname)
        directory=$(pwd)
        madedir="archives"

# sets day of the week for incremental backups
        set $(date)

echo ""
echo "************TESTING drive HDA ***************" > /home/jcz/scripts/drivetests.txt
echo ""
echo "**********************************************" >> /home/jcz/scripts/drivetests.txt
echo $dayer  >> /home/jcz/scripts/drivetests.txt
echo "**********************************************" >> /home/jcz/scripts/drivetests.txt
echo " " >> /home/jcz/scripts/drivetests.txt 
smartctl -c /dev/hda >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
smartctl -l /dev/hda >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
smartctl -v /dev/hda >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
echo "************TESTING drive HDB ***************" >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
smartctl -c /dev/hdb >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
smartctl -l /dev/hdb >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
smartctl -v /dev/hdb >> /home/jcz/scripts/drivetests.txt

echo "" >> /home/jcz/scripts/drivetests.txt
echo "" >> /home/jcz/scripts/drivetests.txt
echo "************ DONE TESTING DRIVES***************"
echo "" >> /home/jcz/scripts/drivetests.txt

