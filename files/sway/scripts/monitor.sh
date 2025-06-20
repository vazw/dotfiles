#!/bin/env sh

swaymsg -t get_outputs -p | grep -E "Output DP-(1|2|3)" >/dev/null &&
	xrandr --output "$(swaymsg -t get_outputs -p | grep -E "Output DP-(1|2|3)" | awk '{print $2}' | head -n 1)" --primary ||
	xrandr --output eDP-1 --primary
