#!/bin/bash
# jcz 15-June-09
# runs mp.exe to check all metadata in the chosen directory
# runs from ArcCatalog-created FGDC xml files
##################################
echo " ******************************* "
echo " This script runs mp.exe and others to check all metadata in the current directory."
echo " It expect ArcCatalog-created FGDC xml files as input and will "
echo " test the existing metadata for integrity, then "
echo " write various output files (according to standard.cfg) to the source directory."
echo " Make sure that the USGS .exe files are in your PATH (c:\windows or /bin) "
echo " ******************************* "


# user enters the directory that contains the .xml metadata 
echo -n "Source directory for .xml files e.g. /cygdrive/c/metadata ( . =
here): "
read  metasrc

for mfiles in $metasrc
do mp.exe -c standard.cfg $mfiles
echo $metasrc
done
