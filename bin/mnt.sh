#!/bin/bash

# Mount drives to their respected places

### Note for both this and the unmount script:
### A lot of pieces of this code repeat themselves, I should rewrite it more efficiently.
### Maybe create mount lists depending on the given options and then run the mount / unmount commands to these lists instead of inside the "if" statements.
### Also maybe add an option to mount / unmount known drives
### More improvement: Use getopts to implement options.

# Initiate mounting list
declare -A mlist

# Mount directory
m_dir="/media/zob203"

case $1 in
    "-h"|"--help"|"")
        echo 'Auto-mount USB drives.

Options:
        -a, --all: Mount all connected drives.
        -u, --unknown: Mount all unknown drives.
        -h, --help: Show this help text and exit.

        Anything else except these options will be considered as a drive name and the script will try to mount it.

Behavior:
        The script searches through fstab for the given name, then creates the directory with that name if it doesnt exist and mounts the drive using its UUID (so be careful when formatting drives, as the UUID changes!).

        Note that the script searches the fstab file as text, so you can give a partial drive name, or a full mount path and it will work.\n This also means that if you give a partial name that corresponds to more than one entries, all this drives will connect (e.g, giving the name "black" connects both "blackstick" and "blackbox").

        This script must be run as root.

By dakodeon, 2017'
    exit 0
        ;;
    "-a"|"--all")
        for uuid in $(blkid -sUUID | grep -v sda | cut -d'"' -f2); do
            path=$(cat /etc/fstab | grep $uuid | cut -d' ' -f2)
            if [[ ! $(mount | grep -q $uuid)  ||  ! $(mount | grep -q $path) ]] ; then
                if cat /etc/fstab | grep -q $uuid; then
                    point=$(cat /etc/fstab | grep UUID | grep $uuid | cut -d' ' -f2)
                else
                    point="$m_dir/$(blkid | grep $uuid | cut -d' ' -f2 | cut -d'"' -f2)"
                fi
                mlist["$uuid"]="$point"
            fi
        done
        ;;
    "-u"|"--unknown")
        for uuid in $(blkid -sUUID | grep -v sda | cut -d'"' -f2); do
            if ! cat /etc/fstab | grep -q $uuid; then
                point="$m_dir/$(blkid | grep $uuid | cut -d' ' -f2 | cut -d'"' -f2)"
                mlist["$uuid"]=$point
            fi
        done
        ;;
    *)
        for uuid in $(cat /etc/fstab | grep UUID | grep $1 | cut -d' ' -f1 | cut -d'=' -f2); do
            if [[ $(mount | grep -c $1) -eq 0 && $(blkid | grep -c $uuid) -gt 0 ]] ; then
                point=$(cat /etc/fstab | grep UUID | grep $uuid | cut -d' ' -f2)
                mlist["$uuid"]="$point"
            fi
        done
        ;;
esac

# Iterate through mlist and mount everything, if the mount-points are non-existent or empty
for uuid in "${!mlist[@]}"; do
    point=${mlist[$uuid]}
    echo "$uuid > $point"
    if [[ ! -d $point  ]]; then
        echo "No mount dir. Creating..."
        mkdir $point
        echo Mounting...
        mount -U $uuid $point
    elif [[ ! $(ls -A $point) ]]; then
        echo "Mount dir is empty"
        echo Mounting...
        mount -U $uuid $point
    else
        echo "Mount dir exists and is NOT empty!"
    fi
done

exit 0
