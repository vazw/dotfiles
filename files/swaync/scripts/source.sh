#!/usr/bin/env -S bash

case $1 in
"--check")
  pactl get-source-mute @DEFAULT_SOURCE@ | grep yes > /dev/null && echo false || echo true
  ;;
"--toggle")
  if [ $SWAYNC_TOGGLE_STATE == true ]; then
    pactl set-source-mute @DEFAULT_SOURCE@ 0
    echo false
  else
    pactl set-source-mute @DEFAULT_SOURCE@ 1
    echo true
  fi
  ;;
*)
  echo false
  ;;
esac
