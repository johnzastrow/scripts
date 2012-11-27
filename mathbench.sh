#!/bin/sh

i=0;
time while [ $i -le 1000 ]; do
        ((i=i + 1))
done;print $i
