# Mount drives to their respected places

if [ $1 = -a ]; then
    sudo blkid -sUUID | grep -v sda | cut -d'"' -f2 | while read uuid; do
        echo "Found" $uuid
        if cat /etc/fstab | grep -q $uuid; then
            dname=$(cat /etc/fstab | grep $uuid | cut -d' ' -f2)
            echo "Mounting known device in" $dname
            if [ ! -d $dname ]; then
                mkdir $dname
            fi
            sudo mount -U $uuid
        else
            dname="/media/zob203/$uuid"
            echo "Mounting unknown device in" $dname
            if [ ! -d $dname ]; then
                mkdir $dname
            fi
            sudo mount -U $uuid $dname
        fi
    done
else
    uuid=$(cat /etc/fstab | grep /$1 | cut -d' ' -f1 | cut -d'=' -f2)
    echo $uuid
    if sudo blkid -sUUID | grep -q $uuid; then
        dname=$(cat /etc/fstab | grep $uuid | cut -d' ' -f2)
        echo "Mounting known device in" $dname
        if [ ! -d $dname ]; then
            mkdir $dname
        fi
        sudo mount -U $uuid
    else
        echo "$1: No such device"
    fi
fi
