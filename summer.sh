#!/bin/sh
echo "1" >sum.txt
declare -a nummer
ls -ls | awk '{ print $1}'| tr -d 'total'> nums.txt
for me in $(cat nums.txt)
do
mike=$(cat sum.txt)
expr "$me+$mike" > sum.txt
done
echo "done!"
cat sum.txt |bc -l
nummer=( `cat "$filename"` )
echo ${nummer[4]} 

element_count=${#nummer[*]}
echo $element_count


# index=0
# Each array element listed on a separate line.
# If this is not desired, use  echo -n "${colors[$index]} "
#
# Doing it with a "for" loop instead:
#   for i in "${colors[@]}"
#   do
#     echo "$i"
#   done
# (Thanks, S.C.)
# The array=( element1 element2 ... elementN ) initialization operation, with the help of command substitution, 
# makes it possible to load the contents of a text file into an array.
#!/bin/bash
# filename=sample_file
#
#            cat sample_file
#
#            1 a b c
#            2 d e fg
# echo "enter listname: "
# read filename
# declare -a array1
# array1=( `cat "$filename" | tr '\n' ' '`)  # Loads contents
                                           # of $filename into array1.
#         list file to stdout.
#                           change linefeeds in file to spaces. 
#
# echo ${array1[@]}            # List the array.
#                              1 a b c 2 d e fg
#
#  Each whitespace-separated "word" in the file
#+ has been assigned to an element of the array.
# element_count=${#array1[*]}
# echo $element_count          # 8
 

