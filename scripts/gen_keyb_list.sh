#!/bin/bash

# Generate a file with i3 keybindings organized alphabetically

for i in {a..z}; do
    # grep "+$i " $HOME/dotfiles/i3/config >> $HOME/temp
    grep "+$i " $HOME/dotfiles/i3/config | while read -r p ; do
        key=$(echo $p | cut -d' ' -f2)
        cmd=${p#*$key}
        echo $key: $cmd >> $HOME/i3binds
    done
    printf "\n" >> $HOME/i3binds
done

# while read p; do
#     key=$(echo $p | cut -d' ' -f2)
#     cmd=${p#*$key}
#     echo $key: $cmd
# done<$HOME/temp
