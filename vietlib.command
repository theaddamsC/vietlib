#!/bin/bash
# *******************************************
# Program: vietlib 
# Author: theaddamsC
# Execution: ./vietlib.command
# Description: download sources
# Example:
# Data: 2019.2.10
# *******************************************
# STOP UPDATE!!!
# can simply use `wget -r -nc URL`


URL="ftp://vietchigo.myds.me/library/"

# test
#URL="ftp://vietchigo.myds.me/library/english/"
#URL="ftp://vietchigo.myds.me/library/photostock/object/"

function getFile(){
	if [[ ${1} == 0 ]]; then
		# root dir
		echo " "
		echo "============= library ================"
		funcURL="$URL"
		LIST_TXT="library.txt"
	else
		# child dir
		echo " "
		echo "============ ${3} ===================="
		funcURL="${2}/"
		LIST_TXT="${3}.txt"
	fi
	
		echo "$funcURL"
	# get files lsit to .txt
	LIST=`curl -l ${funcURL}`
	echo "$LIST" > ${LIST_TXT}

	# read list line by line
	while read -r line
	do
		# check dir/file/tmp
		if [[ $line == "."* ]]; then
			# tmp: do nothing
			echo -e "tmp\t$funcURL$line"
		elif [[ $line == *"."* ]]; then
			# file: download TODO
			echo -e "file\t$funcURL$line"
		else
			#dir: get into TODO
			echo -e "dir\t$funcURL$line"
			
			TMP="$funcURL"
			getFile 1 "$funcURL$line" "$line"
			funcURL="$TMP"
		fi
	done < $LIST_TXT

}


getFile 0

