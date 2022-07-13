#!/bin/bash
#################        BEGIN CONFIGURATION         ################
echo "Start loading configuration...."
echo "Loading option..."
#option 1 - Sort each file"
#option 2 - Sort each folder"
#ex: option=1
option=2
echo "Loading the raw file/ folder..."
###### Begin Configure for option 1 - Sort each file; if option not equal 1, let be blank ###############
#filename - file you want to sorting (ex: filename="APS162OUT")
#rawfile - link file you want to use it's sorting order (ex rawfile="/mnt/d/Script/MVX/APS162OUT.java")
#goalfile - link file you want to sorting follow the rawfile (ex: goalfile="/mnt/d/Script/SPE/APS162OUT.java")
#donefolder - link folder you want to put the success file (ex: donefolder="/mnt/d/Script/DONE")
if [[ $option -eq 1 ]]; then
	filename="OIS199OUT"
	rawfile="/mnt/d/Script/MVX/OIS199OUT.java"
	goalfile="/mnt/d/Script/SPE/OIS199OUT.java"
	donefolder="/mnt/d/Script/DONE"
fi
###### End Configure for option 1 - Sort each file; if option not equal 1, let be blank ##################
#
#
###### Begin Configure for option 2 - Sort each folder; if option not equal 2, let be blank ###############
#rawfolder - link folder you want to use it's sorting order (ex rawfolder="/mnt/d/Script/MVX")
#goalfolder - link folder you want to sorting follow the rawfolder (ex: goalfolder="/mnt/d/Script/SPE")
#donefolder - link folder you want to put the success files (ex: donefolder="/mnt/d/Script/DONE")
if [[ $option -eq 2 ]]; then
	rawfolder="/mnt/d/Script/MVX"
	goalfolder="/mnt/d/Script/SPE"
	donefolder="/mnt/d/Script/DONE"
fi
###### End Configure for option 2 - Sort each folder; if option not equal 2, let be blank ##################
#################        END CONFIGURATION         ###################
echo "Finish loading configuration!"
#################        BEGIN CHECK CONFIGURATION         ###################
echo "Start check configuration..."
echo "Check option..."
if [[ $option -ne 1 ]] && [[ $option -ne 2 ]]; then
	echo "Error! Option $option is invalid!!!"
	exit
else
	if [[ $option -eq 1 ]]; then
		echo "---------------------- OPTION "$option" - SORT EACH FILE ---------------------------"
	fi
	if [[ $option -eq 2 ]]; then
        echo "---------------------- OPTION "$option" - SORT EACH FOLDER -------------------------"
    fi
    echo "Check option success!"
fi
if [[ $option -eq 1 ]]; then
	echo "Start check value must be entered"
	if [[ -z "$filename" ]]; then
		echo "Error! File name must be entered!!!"
		exit
	fi
	if [[ -z "$rawfile" ]]; then
			echo "Error! The raw file must be entered!!!"
			exit
	fi
	if [[ -z "$goalfile" ]]; then
			echo "Error! The goal file must be entered!!!"
			exit
	fi
OAOAOA	if [[ -z "$donefolder" ]]; then
			echo "Error! The done folder must be entered!!!"
			exit
	fi
OAOAOA	echo "Finish check value must be entered"
	echo "Check file name..."	
	if [[ ${#filename} -ne 9 ]]; then
OAOAOA		echo "Error! File name $filename must have the right syntax, example APS162OUT"
		exit
	fi
	if [[ "$filename" != *"OUT"* ]]; then
		echo "Error! File name $filename must have the right syntax, example APS162OUT"
		exit
	fi
	echo "OK! File name is right syntax"
	if [[ "$rawfile" == *"$filename"* ]]; then
	        echo "OK! File name exist in raw file configuration"
	else
		echo "Error! File name $filename is invalid in raw file configuration"
		exit
	fi
	if [[ "$goalfile" == *"$filename"* ]]; then
            echo "OK! File name exist in goal file configuration"
    else
            echo "Error! File name $filename is invalid in goal file configuration"
            exit
    fi
	echo "Check file name success!"
	echo "Check files/ folders..."
	echo "Check raw file..."
	if [[ ! -f "$rawfile" ]]; then
		"Error! The raw file $rawfile does not exist"
		exit
	else
		echo "OK! The raw file is valid"
	fi
	echo "Check goal file..."
    if [[ ! -f "$goalfile" ]]; then
		    "Error! The goal file $goalfile does not exist"
            exit
    else
		echo "OK! The goal file is valid"
    fi
	echo "Check done folder..."
    if [[ ! -d "$donefolder" ]]; then
            "Error! The done folder $donefolder does not exist"
            exit
    else
            echo "OK! The done folder is valid"
    fi
	echo "Check files/ folders success"
fi
if [[ $option -eq 2 ]]; then
    echo "Check files/ folders..."
	echo "Start check value must be entered"
	if [[ -z "$rawfolder" ]]; then
			echo "Error! The raw folder must be entered!!!"
			exit
	fi
	if [[ -z "$goalfolder" ]]; then
			echo "Error! The goal folder must be entered!!!"
			exit
	fi
	if [[ -z "$donefolder" ]]; then
			echo "Error! The done folder must be entered!!!"
			exit
	fi
	echo "Finish check value must be entered"
	echo "Check raw folder..."
	if [[ ! -d "$rawfolder" ]]; then
		"Error! The raw folder $rawfolder does not exist"
		exit
	else
		echo "OK! The raw folder is valid"
	fi
	echo "Check goal folder..."
    if [[ ! -d "$goalfolder" ]]; then
            "Error! The goal folder $goalfolder does not exist"
            exit
    else
		echo "OK! The goal folder is valid"
    fi
	echo "Check done folder..."
    if [[ ! -d "$donefolder" ]]; then
            "Error! The done folder $donefolder does not exist"
            exit
    else
            echo "OK! The done folder is valid"
    fi
	echo "Check files/ folders success"
fi
echo "Finish check configuration!"
#################        END CHECK CONFIGURATION         ###################

