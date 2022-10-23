#!/bin/bash
# vazw
# notify update to polybar

upd=$(xbps-install -nuM | wc -l)

_append ()
{
    cat > ~/.config/bspwm/polybar/needupdate.ini <<EOF
    [needupdate]
    amount = $upd
EOF
}



if [[ "$upd" -gt 0 ]];
then
    _append
    notify-send "Have $upd packages need to update"
elif [[ "$upd" -eq 0 ]];
then
    upd=
    _append
    notify-send "System up-to-date $upd"
fi


exec ~/.config/bspwm/bin/bspbar
