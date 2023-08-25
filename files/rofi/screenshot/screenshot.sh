#!/usr/bin/env bash

dir="$HOME/.config/rofi"
rofi_command="rofi -theme $dir/screenshot/screenshot.rasi"

# Error msg
msg() {
    notify-send "Please install 'scrot' first."
}

# Options
screen="󰹑"
area=""
window=""

# Variable passed to rofi
options="$screen\n$area\n$window"
target="$HOME/Pictures/Screenshots"
if [ ! -d "$target" ]; then
    target="$(xdg-user-dir PICTURES)"
fi

chosen="$(echo -e "$options" | $rofi_command -p 'scrot' -dmenu -selected-row 1)"
case $chosen in
    $screen)
        if [[ -f /usr/bin/scrot ]]; then
            sleep 1; scrot '%Y-%m-%d-%H-%M-%S_$wx$h.png' -e "mv \$f ${target}/\$f"; notify-send "Screenshot Saved"
        else
            msg
        fi
        ;;
    $area)
        if [[ -f /usr/bin/scrot ]]; then
            scrot -s '%Y-%m-%d-%H-%M-%S_$wx$h.png' -e "mv \$f ${target}/\$f"; notify-send "Screenshot Saved"
        else
            msg
        fi
        ;;
    $window)
        if [[ -f /usr/bin/scrot ]]; then
            sleep 1; scrot -u '%Y-%m-%d-%H-%M-%S_$wx$h.png' -e "mv \$f ${target}/\$f"; notify-send "Screenshot Saved"
        else
            msg
        fi
        ;;
esac
