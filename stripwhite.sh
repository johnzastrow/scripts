#!/bin/sh
cdrom=$(volname /dev/cdrom)
cdshort=$(echo $cdrom | sed -e 's/[\n\t\r ]*$//')
echo $cdshort

echo "1   	" >whitespace1.txt
echo "2          "| sed -e 's/[\n\t\r ]*$//' > whitespace2.txt


echo "1"$cdrom >cdromspace1.txt
echo "2"$cdrom | sed -e 's/[\n\t\r ]*$//' > cdromspace2.txt

echo "1"$cdshort >$cdshort.txt

echo "done"
