#!/bin/sh
MUSER="jcz"
MPASS="yub.miha"
MHOST="localhost"
# we don't need this MYSQL=$(which mysql)
# the Bs makes the output appear without the formatting
# and header row.



# Step 1: list all databases EXCEPT core mysql tables and others that can be added
DBS="$(mysql -u$MUSER -p$MPASS -Bse 'show databases' | egrep -v 'information_schema|mysql|test')"

for db in ${DBS[@]}
do

# Step 2: list all tables in the databases
    echo "mysql -u$MUSER -p$MPASS $db -Bse 'show tables'"
    TABLENAMES="$(mysql -u$MUSER -p$MPASS $db -Bse 'show tables')"
    echo "[START DATABASE]"
    echo "Database: "$db
    echo ${TABLENAMES[@]}

# Step 3: perform an optimize (or other op) for all tables returned

        for TABLENAME in ${TABLENAMES[@]}
        do
         echo $TABLENAME
       mysql -u$MUSER -p$MPASS $db -Bse "optimize TABLE $TABLENAME;"  
        done
 echo "[END DATABASE]"
done
