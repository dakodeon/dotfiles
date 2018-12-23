#!/bin/bash

# Generate a file with i3 keybindings organized alphabetically

i3conf=$HOME/dotfiles/i3/i3.conf

echo $i3conf

sed -n '/^mode/,/}/d; /bindsym/s/bindsym //p;' $i3conf | # remove all 'mode' sections, and print only 'bindsym' lines, but without 'bindsym'
    awk '{ c = split($1, a, "+"); # split field 1 (the binding) to substrings, dividing by +
if ($0 ~ /F[0-9]*\s/) { $0 = "0"a[c]"-"$0 }
else if ($0 ~ /(Up|Down|Left|Right)\s/) { $0 = "1"a[c]"-"$0 }
else if ($0 ~ /\+[A-Z][a-z]*\s/) { $0 = "2"a[c]"-"$0 }
else if ($0 ~ /\+[a-z]{2,}\s/) { $0 = "3"a[c]"-"$0 }
else { $0 = "4"a[c]"-"$0 }; # all this is used for bindings sorting order: 1) arrow keys, 2) F keys, 3) special keys, 4) descriptive keys, 5) single charcters
print $0 | "sort" }' | 
    sed 's/^[a-zA-Z0-9]*-//' # remove sorting changes from the output
