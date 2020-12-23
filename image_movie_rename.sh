#!/bin/sh
# jcz 2020-Dec-23
# jcz 2010-Jan-07
# script to rename pictures and video with EXIF create date using exiftool 

############################
# enable for debugging #####
############################
#   set -vx

# The -d switch tells ExifTool to format dates according to the next argument's pattern. 
# The pattern contains date format codes that fill in various bits and pieces from the date. 
# This would rename a file taken today at 17:34 to 20181226-1734-000.nef. 
# The three zeros after the time are a copy number put there by %%-03.c in the date format. 
# I'll explain why that's important in a minute.

# The next argument tells ExifTool to change the filename to whatever is in the CreateDate 
# field in the EXIF using the date format specified earlier.

# Finally, the . is the path of the directory where you want to operate. You can also specify 
# individual images if you want.

# About the copy number: This is an important thing to put in your filenames because many 
# cameras don't provide fractional seconds in their timestamps. If you had multiple files 
# created during the same second, each successive rename would overwrite the last file and 
# all you'd get is the last one. When picking a name, ExifTool will keep incrementing the 
# copy number until it finds a filename that doesn't exist and rename the file to that.

# .%%le means keep the original file name extension, but make it lower-case if 
# it was originally upper-case, a nice option when cameras insist on using "CR2" 
# instead of "cr2". (If you prefer upper-case extensions, then use .%%ue. 
# If you prefer to keep the original case intact, use .%%e.)


   # '-filename<CreateDate' means rename the image file using the image's creation date and time.
   # -d means "Set format for date/time values".
#
   # %y%m%d_%H%M%S%%-c.%%le, used in conjunction with "-d" specifies the format to use for the date and 
  #  time when renaming the file. Breaking the format down:
#
  #  %y%m%d_ means the first part of the new file name should be composed of the last two digits of the 
  #  creation-date year, followed by the month and day, both represented by two digits. The underscore _ means 
  #  put in an underscore after the date part of the file name.
#
 #   %H%M%S means add the hour, minute, and second of the creation time, all represented by two digits.
#
 #   %%-c means that if two images have the same file name up to this point in the naming process, add "a copy 
  #  number which is automatically incremented" to give each image a unique name. Note the doubled %% — necessary 
   # because of something called "escaping" that I don't fully understand. The "-" before the "c" isn't really 
  #  necessary, but it puts a dash before the copy number.
#
 #   .%%le means keep the original file name extension, but make it lower-case if it was originally upper-case, 
 #   a nice option when cameras insist on using "CR2" instead of "cr2". (If you prefer upper-case extensions, 
 #   then use .%%ue. If you prefer to keep the original case intact, use .%%e.)
#
 #   -ext cr2 -ext mrw means only rename files with the "cr2" or "mrw" extension. To rename all image files 
 #   in the source folder, don't specify any extensions.
#
#    -r means "execute this command recursively for every image file in the top "source" folder (that is, the 
#    folder where all the files to be renamed are located), and also for the image files in all the source folder's 
 #   subfolders, sub-subfolders, and so on".
#
 #   /media/ingest/test is the absolute path to the top folder holding all the images to be renamed 
  #  (your path will be different, of course).
#

# this recursibvely below the current directory, renames all files with EXIF data to YYYMMDD_HHMMSS-originalname.[lower case extension]
exiftool '-filename<CreateDate' -d %y%m%d_%H%M%S%%-c-%%f.%%le -r .

# this turns these originals 
# IMG_5447.MOV
# IMG_6325.MOV

# into
# 201114_184737-IMG_5447.mov
# 201114_141151-IMG_6325.mov

