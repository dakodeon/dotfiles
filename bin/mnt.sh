# Mount drives to their respected places

### Note for both this and the unmount script:
### A lot of pieces of this code repeat themselves, I should rewrite it more efficiently.
### Maybe create mount lists depending on the given options and then run the mount / unmount commands to these lists instead of inside the "if" statements.
### Also maybe add an option to mount / unmount known drives

if [ $1 = -h ] || [ $1 = --help ]; then
    echo 'Auto-mount USB drives.\n
Options:\n
        -a, --all: Mount all connected drives.\n
        -u, --unknown: Mount all unknown drives.\n
        -h, --help: Show this help text and exit.\n
        Anything else except these options will be considered as a drive name and the script will try to mount it.\n
Behavior:\n
        The script searches through fstab for the given name, then creates the directory with that name if it doesnt exist and mounts the drive using its UUID (so be careful when formatting drives, as the UUID changes!).\n
        Note that the script searches the fstab file as text, so you can give a partial drive name, or a full mount path and it will work.\n This also means that if you give a partial name that corresponds to more than one entries, all this drives will connect (e.g, giving the name "black" connects both "blackstick" and "blackbox").\n
        This script must be run as root.\n
By dakodeon, 2017'
elif [ $1 = -a ] || [ $1 = --all ]; then
    blkid -sUUID | grep -v sda | cut -d'"' -f2 | while read uuid; do
        echo "Found" $uuid
        if cat /etc/fstab | grep -q $uuid; then
            point=$(cat /etc/fstab | grep $uuid | cut -d' ' -f2)
            echo "Mounting known drive in" $point
            if [ ! -d $point ]; then
                mkdir $point
            fi
            mount -U $uuid
        else
            point="/media/zob203/$uuid"
            echo "Mounting unknown drive in" $point
            if [ ! -d $point ]; then
                mkdir $point
            fi
            mount -U $uuid $point
        fi
    done
elif [ $1 = -u ] || [ $1 = --unknown ]; then
    blkid -sUUID | grep -v sda | cut -d'"' -f2 | while read uuid; do
        if ! cat /etc/fstab | grep -q $uuid; then
            echo "Found" $uuid
            point="/media/zob203/$uuid"
            echo "Mounting unknown drive in" $point
            if [ ! -d $point ]; then
                mkdir $point
            fi
            mount -U $uuid $point
        fi
    done
else
    uuid=$(cat /etc/fstab | grep /$1 | cut -d' ' -f1 | cut -d'=' -f2)
    echo $uuid
    if blkid -sUUID | grep -q $uuid; then
        point=$(cat /etc/fstab | grep $uuid | cut -d' ' -f2)
        echo "Mounting known drive in" $point
        if [ ! -d $point ]; then
            mkdir $point
        fi
        mount -U $uuid
    else
        echo "$1: No such drive"
    fi
fi
