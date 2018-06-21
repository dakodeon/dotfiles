#!/bin/bash

# setup dotfiles repository location
REPO=$HOME/dotfiles

# define the help message
helpmsg='Update configuration files by using hard links from the repo to the correct place by using a file list.\n
This is inteded to be used only for dotfiles placed in your home directory.\n\n

Usage:\n\t
	-u --update: Updates config files:\n\t\t
	   all: Updates all config files listed in the file list\n\t\t
	   allb: Same as above but keeps backups of the original files\n\t\t
	   Everything else is treated like a filename, so the script tries to update that file, if it exists.\n\t
	-a --add: Adds a file to the repository\n\t
	-l --list: Outputs a list of files currently in the repository.\n\t
	-g --gen-list: Generates the file list according to the contents of the repository.\n'

# if there are no arguments, print the help file
if (($# == 0)); then
    echo -e $helpmsg
fi

# parse options
while getopts ":ua:lgbh" opt; do
    case $opt in
	u)
	    echo "-u was triggered. Updating..."
	    while read line; do
		source=$REPO/$(echo $line | cut -d'"' -f2)
		dest=$HOME/$(echo $line | cut -d'"' -f4)
		if [ ! -f $dest ]; then
		    echo File $dest does not exist, creating link...
		    ln -f $source $dest
		else
		    echo File $source exists in location, checking inodes
		fi
	   
	    done<$REPO/filelist
	    ;;
	a)
	    echo "-a was triggered, adding file: $OPTARG" >&2
	    ;;
	l)
	    echo "-l was triggered, here are the files."
	    ;;
	g)
	    # echo "-g was triggered, generating list"
	    find $REPO -maxdepth 1 -type d | grep -v .git | grep -v $REPO$ | while read -r p; do
		echo =-=-=-= Setup path for ${p#*$REPO/}
		find $p -type f | while read -r e; do
		    echo ${e#*$REPO/}
		done
	    done
	    ;;
	:)
	    echo "Option $OPTARG requires an argument..." >&2
	    ;;
	b)
	    echo "-b was triggered, keeping backups ON"
	    ;;
	h)
	    echo -e $helpmsg
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    exit 1
	    ;;
       	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    exit 1
	    ;;
    esac
done
