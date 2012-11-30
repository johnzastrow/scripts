#!/bin/sh
# jcz 27-nov-2012
# unzip all zip files in current directory into a folder named after the 
# basename of the zip. For example: in directory ~/Documents/MyZipfile.zip
# it will inflate the contents of MyZipfile.zip into a newly
# created directory ~/Documents/MyZipfile/
for x in *.zip; do echo "$x"; unzip -d "${x%.zip}" "$x"; done