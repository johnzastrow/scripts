#!/bin/sh

for w in `cat names.txt`; 
do echo -n "Looking for $w: ";  grep -in $w tribes.txt ; done
