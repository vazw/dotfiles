#!/usr/bin/env bash

dir="$HOME/.config/rofi"
rofi_command="rofi -theme $dir/screenshot/screenshot.rasi"

# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "Please install 'scrot' first."
}

# Options
screen=""
area=""
# window=""

# Variable passed to rofi
options="$screen\n$area"

chosen="$(echo -e "$options" | $rofi_command -p '' -dmenu -selected-row 1)"
case $chosen in
$screen)
	if [[ -f /usr/bin/scrot ]]; then
		sleep 1
		scrot -F '%Y-%m-%d-%H-%M-%S_$wx$h.png' -e 'mv $f ~/Pictures/screenshot/'
	else
		msg
	fi
	;;
$area)
	if [[ -f /usr/bin/scrot ]]; then
		scrot -s -f -F '%Y-%m-%d-%H-%M-%S_$wx$h.png' -e 'mv $f ~/Pictures/screenshot/' 
	else
		msg
	fi
	;;
esac
