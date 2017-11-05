# Unmount drives and clean up

if [ $1 = -h ] || [ $1 = --help ]; then
    echo 'Auto-unmount USB drives.\n
Options:\n
        -a, --all: Unmount all mounted drives.\n
        -u, --unknown: Unmount all unknown drives.\n
        -h, --help: Show this help text and exit.\n
        Anything else except these options will be considered as a drive name and the script will try to unmount it.\n
Behavior:\n
        The script searches the output of the mount command for the given mount point. It unmounts the drive and removes the mount point, if the unmount command was successful.\n
        Note that you can also give a partial name for the mount point, the drive name in /dev, or even an earlier path (like the directory containing all the mount points). It will still work.\n
        The script must be run as root.\n
By dakodeon, 2017'
elif [ $1 = -a ] || [ $1 = --all ]; then
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
elif [ $1 = -u ] || [ $1 = --unknown ]; then
    mount | grep -v sda | grep dev/sd | cut -d' ' -f3 | while read point; do
        if ! cat /etc/fstab | grep -q $point; then
            echo "Unmounting unknown drive from" $point
            sudo umount $point
            if [ $? = 0 ]; then
                echo "Removing" $point
                rm -r $point
            else
                echo "Could not remove $point. Remove it manually."
            fi
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
        echo "$1: No such drive."
    fi
fi

