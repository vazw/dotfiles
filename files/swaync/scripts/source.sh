#!/usr/bin/env -S bash

case $1 in
"--check")
  pactl get-source-mute @DEFAULT_SOURCE@ | grep yes > /dev/null && echo false || echo true
  break 
  ;;
"--toggle")
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
  pactl get-source-mute @DEFAULT_SOURCE@ | grep yes > /dev/null && echo false || echo true
  break 
  ;;
*)
  echo false
  ;;
esac
