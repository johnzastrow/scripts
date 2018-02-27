
#!/bin/sh
MUSER="jcz"
MPASS="yub.miha"
MHOST="localhost"
MYSQL="$(which mysql)"
# the Bs makes the output appear without the formatting
# and header row.
# Step 1: list all databases EXCEPT core mysql tables and others that can be added
DBS="$($MYSQL -u$MUSER -p$MPASS -Bse 'show databases' | egrep -v 'information_schema|mysql|test')"

for db in ${DBS[@]}
do

# Step 2: list all tables in the databases
    echo "$MYSQL -u$MUSER -p$MPASS $db -Bse 'show tables'"
    TABLENAMES="$($MYSQL -u$MUSER -p$MPASS $db -Bse 'show tables')"
    echo "[START DATABASE]"
    echo "Database: "$db
    echo ${TABLENAMES[@]}

	
	
	
# Step 3: perform an optimize (or other op) for all tables returned

        for TABLENAME in ${TABLENAMES[@]}
        do
         echo $TABLENAME
       $MYSQL -u$MUSER -p$MPASS $db -Bse "optimize TABLE $TABLENAME;"  
        done
 echo "[END DATABASE]"
done
