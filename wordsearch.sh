#!/bin/sh
dater=$(date +%Y%m%d%S)_names
cute=$(date +%Y%m%d%S)_uniqs
echo -n "Enter file to create unique words from: "
read filer
echo -n "Enter output file: "
read output
for w in `cat $filer`;
do echo $w; 
done | sort -u > $dater.txt;
uniq -ci $dater.txt > $cute.txt;

num=1
for name in $(cat $cute.txt);
echo "$name $num" > $output
let num+=1
done
