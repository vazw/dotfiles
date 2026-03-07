#!/usr/bin/bash

bt_state=$(bluetoothctl show | grep PowerState | awk '{print $2}')

echo "$@"
case $1 in
"--check")
    if [ "$bt_state" == "off" ]; then
        echo false
    else
        echo true
    fi
    shift
    ;;
"--toggle")
    if [ "$bt_state" == "off" ]; then
        bluetoothctl power on
        echo true
    else
        bluetoothctl power off
        echo false
    fi
    shift
    ;;
*)
    echo false
    ;;
esac
