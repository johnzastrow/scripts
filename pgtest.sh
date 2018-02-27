#!/bin/sh
# jcz 2015-Nov-16
# This script will perform semi-automated, logged benchmarks 
# of a local postgres database server using the pgbench utility provided by 
# your postgresql installation. 

echo "Hi. i'm going to do some stuff with your database. "
echo "Are you running me as the user postgres that owns the server? "
echo "If not, ctrl+z now"

# Variables pretty self explanatory, S is seconds
alog=$(date +%Y%m%d%S)_alog.txt

dater=$(date +%Y%m%d%S)
namer=$(hostname)
directory=$(pwd)
madedir="perflogs"
pg_conf="posgresql.conf"

pghba =$(psql -t -P format=unaligned -c 'show hba_file';)
psql -t -P format=unaligned -c 'show config_file';

# start the log

echo $dater > $alog
echo "POSTGRESQL bench marking run information " >> $alog
echo " ---------------- " >> $alog
echo " Host where benchmark is running " >> $alog
echo $namer >> $alog
echo " Directory where the benchmark is run from and log file is created " >> $alog
echo $directory >> $alog
echo " location  " >> $alog
echo $pg_conf >> $alog
stat $pg_conf >> $alog

echo "WELCOME TO THE BENCHMARKING SHELL SCRIPT FOR POSTGRESQL ON" $namer

# Record the working contents of posgresql.conf using a clumsy awk 
# print all lines that do NOt begin with # and then print only only lines contain
# characters other than any white space.
awk '$1!~/^#/' postgresql.conf | awk '/\S/' 



createdb -O postgres bencher

# Now we can fill it up with pgbench:
pgbench -i -U --foreign-keys postgres bencher

# and now we can test things
pgbench -c 4 -S -t 2000 -U postgres bencher
pgbench -c 4 -t 2000 -U postgres bencher
