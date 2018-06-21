#!/usr/bin/bash

interval=1

# boolean to run notification once
lowbat=true

while true; do
    sleep $interval

    status=$(acpi | cut -d ":" -f2 | cut -d"," -f1 | tr -d " ")
    percent=$(acpi | cut -d ":" -f2 | cut -d"," -f2 | tr -d " " | tr -d "%")

    $fulltext="$percent\%"
    echo fulltext is $fulltext

    if [ $status == Charging ] ; then
        fulltext="$fulltext CHR"
        echo fulltext is now $fulltext
    elif [ $status == Discharging ] ; then
        fulltext="$fulltext DIS"
    fi

    if [ $status == Discharging ] ; then
        if [ $percent -lt 20 ] ; then
            if [ "$lowbat" = false ] ; then
                notify-send -u critical "Battery is running low\n System will soon hibernate."
            fi
            echo "#FF0000\n"
            lowbat=true
        elif [ $percent < 40 ] ; then
            echo "#FFAE00\n"
        elif [ $percent -lt 60 ] ; then
            echo "#FFF600\n"
        elif [ $percent -lt 85 ] ; then
            echo "#A8FF00\n"
        elif [ $percent -lt 100 ] ; then
            echo "#00FF00\n"
        fi
    elif [ $status == Charging ] ; then
        if [ $percent -eq 100 ] ; then
            echo "#00FF00\n"
        fi
    fi
    echo fulltext is finally $fulltext

done

