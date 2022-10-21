#!/usr/bin/env bash

# vazw
# notify update to polybar

upd="$(xbps-install -nuM | wc -l)"

_append ()
{
    cat > ~/.config/bspwm/polybar/needupdate.ini <<EOF
    [needupdate]
    amount =$upd
EOF
}

if [[ "$upd" -lt 0 ]];
then
    _append && notify-send "Have $upd packages need to update"
elif [[ "$upd" < 1 ]];
then
    upd=
    _append && notify-send "Have Updated all packages $upd"
fi
