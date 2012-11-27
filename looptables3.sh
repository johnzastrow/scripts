#!/bin/sh
MUSER="jcz"
MPASS="yub.miha"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
# the Bs makes the output appear without the formatting
# and header row.
# Step 1: list all databases

DBS="$($MYSQL -u$MUSER -p$MPASS -Bse 'show databases')"
# echo "" > optimize.sql

for db in ${DBS[@]}
do

# Step 2: list all tables in the databases
#    echo "" > optimize_$db.sql
    echo "$MYSQL -u$MUSER -p$MPASS $db -Bse 'show tables'"
    TABLENAMES="$($MYSQL -u$MUSER -p$MPASS $db -Bse 'show tables')"
    echo "[START DATABASE]"
    echo "Database: "$db
    echo ${TABLENAMES[@]}

# Step 3: perform an optimize (or other op) for all tables returned
# right now we'll just write out a sql file and call it separately because
# I acn't this script working to call the command on the fly

        for TABLENAME in ${TABLENAMES[@]}
        do
         echo $TABLENAME
	 echo "use "$db >> optimize.sql
         echo "optimize TABLE $TABLENAME;" >> optimize.sql
#        echo "$MYSQL -u$MUSER -p$MPASS $db -Bse 'optimize TABLE $TABLENAME;'" >> optimize_$db.sql 
#        $MYSQL -u$MUSER $db -Bse 'optimize TABLE $TABLENAME;'   
        done
 echo "[END DATABASE]"
done

$MYSQL -u$MUSER -p$MPASS < optimize.sql


###
# DBS="$($MYSQL -u$MUSER -Bse 'show databases')"
#  is an array 
#  ${DBS[@]} - prints all its members
#  
#  
#  bash -x script.sh <-'
#  to see verbose output
