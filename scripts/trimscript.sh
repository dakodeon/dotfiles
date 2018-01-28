#!/bin/bash

# trimming facility using a file with list of tracks and start/end points

while read f; do
    name=$(echo $f | cut -d'"' -f2)
    start=$(echo $f | cut -d'"' -f4)
    stop=$(echo $f | cut -d'"' -f6)

    sox "$name" "trimmed/$name" trim $start =$stop
done<$HOME/20180122-recs/timelist
