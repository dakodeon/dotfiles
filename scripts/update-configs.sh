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
            echo "All files to be updated"
        else
            echo "File $2 is to be updated"
        fi
        exit 0
        ;;
    "-a"|"--add")
        echo "File $2 is to be added to the repo"
        exit 0
        ;;
    "-l"|"--list")
        echo "Here is the list of files"
        exit 0
        ;;
esac

