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


# case $1 in
#     "-h"|"--help"|"")
#         echo 'Update configuration files by using hard links from the repo to the correct place by using a file list. This is inteded to be used only for dotfiles placed in your home directory.

# Usage:
# 	-u --update: Updates config files:
# 	   	     all: Updates all config files listed in the file list
# 		     allb: Same as above but keeps backups of the original files
# 		     Everything else is treated like a filename, so the script tries to update that file, if it exists.
# 	-a --add: Adds a file to the repository
# 	-l --list: Outputs a list of files currently in the repository.
# 	-g --gen-list: Generates the file list according to the contents of the repository.'
#         exit 0
#         ;;
#     "-u"|"--update")
#         if [ $2 == all ] ; then
#             echo "All files to be updated. The program will parse a list of files and, for each one, will create a new link to the correct place."
# 	    while read f; do
# 		source=$HOME/$(echo $f | cut -d'"' -f2)
# 		dest=$HOME/$(echo $f | cut -d'"' -f4)
# 		echo Linking $source to $dest
# 		ln -f $source $dest
# 	    done<$HOME/dotfiles/filelist
# 	elif [ $2 == allb ] ; then
# 	    echo "All files to be updated, while keeping backup files of the originals. For each file in the list, if the file exists in its path, it will first rename the file to file.BAK, and then function as above."
	    
#         else
#             echo "File $2 is to be updated. The program will check if this file is on the list. If it is not, it will prompt the user to add it to the repo. If it is, it will create a new link for this file."
#         fi
#         exit 0
#         ;;
#     "-a"|"--add")
#         echo "File $2 is to be added to the repo. The program will parse the list of files. If the file exists already, it will check if the files are the same. If they are, the program will exit. If they are not, it will check the modification dates and will inform the user and ask him what to do. After adding a program to the repo, it will also update the filelist."
#         exit 0
#         ;;
#     "-l"|"--list")
#         cat $HOME/dotfiles/filelist
#         exit 0
#         ;;
#     "-g"|"--gen-list")
# 	echo "Generate the filelist. Will ask for user prompt for the various locations of the config files."
# esac

