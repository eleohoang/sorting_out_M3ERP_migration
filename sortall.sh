#!/bin/bash
#get configuration
source ./config.sh
# 1 - Sort each file
if [[ $option -eq 1 ]]; then
	#sorting for a file
	echo "---------------------- BEGIN SORTING FOR $filename -------------------------"
	source ./eachfile.sh
	echo "---------------------- FINISH SORTING FOR $filename ------------------------"
fi
# 2 - Sort each folder
if [[ $option -eq 2 ]]; then
    unset zcount;
	zcount=0
	# create the list file need to sorting
	rm -f ./listfiles.txt
	touch ./listfiles.txt
	ls "$goalfolder" >>./listfiles.txt
	listfiles="./listfiles.txt"
	while IFS= read -r outname
	do 
		zcount=`expr $zcount + 1`
		# get file from folder
		filename="${outname/OUT*/OUT}"
		echo "---------------------- BEGIN SORTING FOR $filename -------------------------"
		rawfile="$rawfolder/$outname"
		goalfile="$goalfolder/$outname"
		#sorting for each file
		source ./eachfile.sh
		echo "---------------------- FINISH SORTING FOR $filename ------------------------"
	done <"$listfiles" 
	#notice that no file exists
	if [[ zcount -eq 0 ]]; then
		echo "No file exists!"
	fi
	rm -f ./listfiles.txt
fi
