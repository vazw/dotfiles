#!/bin/bash
WIFI=($(nmcli device | awk '$2=="wifi" {print $1}'))
WIRE=($(nmcli device | awk '$2=="ethernet" {print $1}'))
echo $WIRE
cat > ~/.config/bspwm/polybar/interfaces.ini <<EOF
[interfaces]
WIFI =$WIFI
WIRE =$WIRE
EOF
