#!/bin/sh
# jcz 2004-jan-12

umount /mnt/cdrom
# assumes iso9660 CD-ROM
mount -t iso9660 -r /dev/cdrom /mnt/cdrom

# makes the directory to store the catalog files
mkdir cdcatalogs

echo -n "Enter some descriptive text about the contents of the media: "
echo ""
read contents
echo " "

echo -n "Enter the media ID or the label that is written on the disk (in the format mediaid_41 for disk 41): "
echo ""
read mediaid

# runs volname (part of the eject program) to extract the volume label information
cd=$(volname /dev/cdrom)

# trims white space after the name always written out by volname
cdshort=$(echo $cd | sed -e 's/[\n\t\r ]*$//')_$mediaid
volume=$(echo $cd | sed -e 's/[\n\t\r ]*$//')
echo "This volname is: "$cd
echo "I am going to make " $cdshort"_catalog.txt"
disk=$cdshort"_catalog.txt"
echo "Echoing disk " $disk

echo "Disk Volume Label: "$volume > $disk
echo "We will call this disk: "$cdshort >> $disk
echo "" >> $disk

echo "Disk Media ID: "$mediaid >> $disk
echo "" >> $disk

echo "##### Description: #### " >> $disk
echo $contents >> $disk 
echo "####################### " >> $disk
echo "" >> $disk
# keeps only relevant columns from ls, and date is in a fixed length format which is understandable 
# by M$ Office products if needed
ls -ghGR --full-time /mnt/auto/cdrom | awk '{ print $1 "\t" $3 "\t"$4 " " $5 "\t"$7 $8 $9 $10 $11 }'>> $disk
echo "" >> $disk

# print zip file contents to the file
echo "" >> $disk
echo "##### Zip file contents: #### " >> $disk
echo $contents >> $disk
echo "####################### " >> $disk
echo "" >> $disk
ls /mnt/auto/cdrom/*.zip | xargs -n1 unzip -l >> $disk


# print cab file contents to the file
echo "" >> $disk
echo "##### .cab file contents: #### " >> $disk
echo $contents >> $disk
echo "####################### " >> $disk
echo "" >> $disk
ls /mnt/auto/cdrom/*.cab | xargs -n1 unzip -l >> $disk


# print jar file contents to the file
echo "" >> $disk
echo "##### JAR file contents: #### " >> $disk
echo $contents >> $disk
echo "####################### " >> $disk
echo "" >> $disk
ls /mnt/auto/cdrom/*.jar | xargs -n1 unzip -l >> $disk


# fixes the line endings for windows if you want read the catalogs directly in Notepad
unix2dos $disk

# moves file to consistent directory
mv $disk cdcatalogs/

umount /mnt/cdrom
# ejects the disk when done to prepare for next disk
eject

echo "less cdcatalogs/"$disk
