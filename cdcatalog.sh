#!/bin/sh
# jcz 2004-jan-12
clear

echo "Disc Mounted. Run this program, then grep keywords in the "
echo "cdcatalogs directory to find which CD-ROM some file "
echo "is on. "

# makes the directory to store the catalog files
mkdir /cygdrive/c/cdcatalogs

# runs volname (part of the eject program) to extract the volume label information
cd=$(volname /dev/cdrom)

# enter user defined CD label (something written on the CD itself)
echo -n "Enter written CD-ROM label and any notes from the disc itself: "
read labler


# trims white space after the name always written out by volname
cdshort=$(echo $cd | sed -e 's/[ntr ]*$//')
echo $cdshort
echo $cdshort"_catalog.txt"
disk=$cdshort"_catalog.txt"
echo $disk
echo $labler
echo "Disk Volume Label: "$cdshort > $disk
echo "Label and Notes on Disc: " $labler >> $disk
echo " ------------------------------------------" >> $disk
echo "-------- <<<<END DISC ENTRY>>> ------------" >> $disk
echo " ------------------------------------------" >> $disk
echo " " >> $disk

# keeps only relevant columns from ls, and date is in a fixed length format which is understandable
# by M$ Office products if needed
ls -ghGR --full-time /mnt/cdrom | awk '{ print $1 "t" $3 "t"$4 " " $5 "t"$7 $8 $9 $10 $11 }'>> $disk

# fixes the line endings for windows if you want read the catalogs directly in Notepad
unix2dos $disk

# moves file to consistent directory
mv $disk cdcatalogs/

ls -lht cdcatalogs/

umount /mnt/cdrom
# ejects the disk when done to prepare for next disk
eject