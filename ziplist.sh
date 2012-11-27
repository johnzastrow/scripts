#!/bin/bash
# jcz 13-sep-05
# list the contents of zips (or tar.gz)
# in the directory in which it is run
# ziplist.sh 
##################################
for zp in *.zip
do unzip -l $zp
done
