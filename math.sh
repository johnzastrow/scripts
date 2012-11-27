#!/bin/sh

i=0;
time while [ $i -le 1000 ]; do
        i=`expr $i + 1`
done;print $i

