#!/bin/bash
# jcz 10-dec-08
# v1 10-dec-08
# appends text from multiple text files into one text file
# in the directory in which it is run
# TODO: option to include only the lines of interest into the new file
# try using grep and then some characters that are common to all lines
# that we want to keep.
##################################

OPTIONS="Hello Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "Hello" ]; then
                echo Hello World
               else
                clear
                echo bad option
               fi
           done
