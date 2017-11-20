#!/bin/bash

# Rename mp3 tracks according to metadata
# depends on ffprobe, part of the ffmpeg package

# Version 1: Experimental

# What to do:
# 1. Read an argument and determine if it is a file, a folder or non-existent
# 2. If it is a file, perform the renaming for this file.
# 3. If it is a folder, read all mp3 files in that folder and perform the renaming for each one.
# 4. If it is non-existent, exit with error code 2

declare -a files

echo "Welcome to Dakode's mp3 renaming facility."
while [[ $# -gt 0 ]]; do
    if [[ -d "$1" ]]; then
        for i in "$1"/*.mp3; do
            files=("${files[@]}" "$i")
        done
    elif [[ -f "$1" ]]; then
        if echo "$1" | grep -q .mp3; then
            files=("${files[@]}" "$1")
        fi
    else
        echo "Argument is shit"
    fi
    shift
done

echo Renaming...
for i in "${files[@]}"; do
    # echo $(dirname "$i")/$(basename "$i" | tr ' ' '_')
    data=("$(ffprobe -loglevel error -show_entries format_tags=title,artist,composer,date "$i" | cut -s -d':' -f2)")
    if [[ $(echo "$data" | grep -c title) -gt 0 && $(echo "$data" | grep -c artist) -gt 0 ]]; then
        artist=$(echo "$data" | grep artist | cut -d'=' -f2 | tr ' ' '_')
        title=$(echo "$data" | grep title | cut -d'=' -f2 | tr ' ' '_')
        if [[ $(echo "$data" | grep -c composer) -eq 0 || $(echo "$data" | grep composer | cut -d'=' -f2 | tr ' ' '_') == $artist ]]; then
            name=$artist-$title
        else
            composer=$(echo "$data" | grep composer | cut -d'=' -f2 | tr ' ' '_')
            name="$composer($artist)-$title"
        fi
        old="$(dirname "$i")/$(basename "$i")"
        new="$(dirname "$i")/$name.mp3"
        if [[ $old != $new ]]; then
            mv "$old" "$new"
        fi
    fi
done
