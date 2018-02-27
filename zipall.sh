#!/bin/bash
# jcz 13-sep-05
# zips (or tar.gz) all directories
# in the directory in which it is run
##################################
echo " ******************************* "
echo " this app zips all directories in this directory,"
echo " tests the created zips for integrity, then "
echo " copies them to some directory."
echo " ******************************* "
###  his scrip can be adaped to unzip wih something like
##       
## find . -type f | while read file -- but need to search on name with *.zip
## do
##   unzip $file
## done


# user enters the directory that they want the zips copied to
echo -n "Destination directory for zips e.g. /cygdrive/f/BACKUPS ( . =
here): "
read dest

for dir in */
do dir=`echo $dir | tr -d '/'`
echo $dir

# for zipping, -r recurse into directories
# and -u update new or changed files
# echo "zip -r" $dir.zip $dir'/*'
zip -ru $dir.zip $dir

# to test zip file integrity
zip -T $dir.zip

# move the zips to some directory
mv -v $dir.zip $dest

# for gzipping
# tar czf $dir.tar.gz $dir
done
