!#/bin/sh

# quoter=/"
# singler=/'

echo "YOU HAD BETTER BE AN ADMIN. WELCOME TO NEW USER SETUP SCRIPT"
echo -n "Enter NEW USERNAME: "
read namer
echo -n "Enter USER password"
read pword

echo "CREATING DB"
echo "create database" $namer ";" > $namer.sql
echo "grant all privileges on" $namer".* to" $namer"@localhost identified by '"$pword"' with grant option;" >>$namer.sql
echo "grant all privileges on" $namer".* to" $namer"@\"%\" identified by '"$pword"' with grant option;" >>$namer.sql

