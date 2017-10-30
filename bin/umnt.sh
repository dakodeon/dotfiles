# Unmount specific drive -- also with option to unmount all
# Usage: give as an argument a name of a drive or the mounting point to unmount (e.g 'sdb1' or 'ducktaped'). Give -a as an argument to unmount everything.

if [ $1 = -a ]; then
    mount | grep -v sda | grep dev/sd | cut -d' ' -f3 | while read point; do
        echo "Unmounting drive from" $point
        sudo umount $point
        if [ $? = 0 ]; then
            echo "Removing" $point
            rm -r $point
        else
            echo "Could not remove $point. Remove it manually."
        fi
    done
else
    if mount | grep -v sda | grep dev/sd | grep -q $1; then
        point=$(mount | grep -v sda | grep dev/sd | grep $1 | cut -d' ' -f3)
        echo "Unmounting drive from" $point
        sudo umount $point
        if [ $? = 0 ]; then
            echo "Removing" $point
            rm -r $point
        else
            echo "Could not remove $point. Remove it manually."
        fi
    else
        echo "$1: No such device."
    fi
fi

