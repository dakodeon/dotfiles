#!/bin/bash

case $1 in
    "-h"|"--help"|"")
        echo 'Help prints here.

This can be done and that can be done, and then the other thing.
Some stuff here and some stuff there.'
        exit 0
        ;;
    "-u"|"--update")
        if [ $2 == all ] ; then
            echo "All files to be updated. The program will parse a list of files and, for each one, will create a new link to the correct place."
	elif [ $2 == allb ] ; then
	    echo "All files to be updated, while keeping backup files of the originals. For each file in the list, if the file exists in its path, it will first rename the file to file.BAK, and then function as above."
	    
        else
            echo "File $2 is to be updated. The program will check if this file is on the list. If it is not, it will prompt the user to add it to the repo. If it is, it will create a new link for this file."
        fi
        exit 0
        ;;
    "-a"|"--add")
        echo "File $2 is to be added to the repo. The program will parse the list of files. If the file exists already, it will check if the files are the same. If they are, the program will exit. If they are not, it will check the modification dates and will inform the user and ask him what to do. After adding a program to the repo, it will also update the filelist."
        exit 0
        ;;
    "-l"|"--list")
        echo "Here is the list of files"
        exit 0
        ;;
esac

