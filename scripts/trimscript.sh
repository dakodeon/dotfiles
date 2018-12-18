#!/bin/bash

# trimming facility using a file with list of tracks and start/end points
declare -A TIMELIST

mkdir originals
echo "Define starting and ending points (m:ss format), separated by space:"
for file in *mp3; do
    read -p "$file: " TIMELIST["$file"]
    cp "$file" "originals/$file"
done

echo "Starting trimming..."
for file in "${!TIMELIST[@]}"; do
    start=$(echo ${TIMELIST[$file]} | cut -d' ' -f1)
    end=$(echo ${TIMELIST[$file]} | cut -d' ' -f2)
    # echo FILE: \"$i\" start: $start end:$end
    sox "originals/$file" "$file" trim $start \=$end
    echo File \"$file\" ready.
done

echo "Done. Original files are copied to the 'originals' directory."

# check for input format - regexp???
# add options -- keep originals or delete them
# add checks -- check if mp3 list is empty, check if originals is empty and remove it
