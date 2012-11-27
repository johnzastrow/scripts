#!/bin/sh
MUSER="jcz"
MPASS="yub.miha"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
NOW=$(date +"%d-%m-%Y")
GZIP="(which gzip)"
# the Bs makes the output appear without the formatting
# and header row.
# Step 1: list all databases

DBS="$($MYSQL -u$MUSER -p$MPASS -Bse 'show databases')"

for db in ${DBS[@]}
do

# Step 2: list all tables in the databases
#    echo "" > optimize_$db.sql
    echo "$MYSQL -u$MUSER -p$MPASS $db -Bse 'show tables'"
    TABLENAMES="$($MYSQL -u$MUSER -p$MPASS $db -Bse 'show tables')"
    echo "[START DATABASE]"
    echo "Database: "$db
    echo ${TABLENAMES[@]}
    FILE=mysql-$db.$NOW-$(date +"%T").gz
    $MYSQLDUMP --opt -u $MUSER -h $MHOST -p$MPASS $db | gzip -9 > $FILE
   done
