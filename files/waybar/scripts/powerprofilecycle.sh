#!/bin/bash
#
# Script to cycle through power-profiles-daemon profiles. Handy for integration
# with waybar, i3blocks and others. When run it will cycle to next profile and
# output a corresponding fa-icon for displaying in a bar. With the -m toggle,
# the script will not cycle profiles, rather just print fa-icon corresponding to
# current profile.
#

PSET="powerprofilesctl set"
PGET="powerprofilesctl get"

while getopts "mh" opt; do
    case $opt in
        m)
            case $($PGET) in
                power-saver)
                    printf "\npower-saver"  && exit 0
                    ;;
                balanced)
                    printf "\nbalanced" && exit 0
            esac
            ;;
        h)
            echo -e "Run script without arguments to cycle power profiles and print icon. \n-m Monitor. Get power profile and print icon. \n-h Help. Show this help text"
            exit 0
            ;;
        *)
            echo "Invalid option. Try -h."
            exit 1
    esac
done

case $($PGET) in
    power-saver)
        $PSET balanced && printf "\nbalanced" && exit 0
        ;;
    balanced)
        $PSET power-saver && printf "\npower-saver"  && exit 0
        ;;
esac

echo "Could not find power profile match. Is power-profiles-daemon running?"
exit 1
