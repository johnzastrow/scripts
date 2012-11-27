#!/bin/sh
# jcz 27-aug-07
# script to make directories for mantis project uploads
clear
echo "Enter a small, one word project name that will become"
echo " the directory name for the file uploads." 
read projname


mkdir /home/ttbugs/public_html/uploads/$projname
chown -R apache:apache /home/ttbugs/public_html/uploads/$projname
chmod -R 755 /home/ttbugs/public_html/uploads/$projname

ls -lht /home/ttbugs/public_html/uploads/
