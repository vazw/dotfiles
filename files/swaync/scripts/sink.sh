#!/usr/bin/env -S sh

case $1 in
--check)
    pactl get-sink-mute @DEFAULT_SINK@ | grep yes >/dev/null && echo false || echo true
    shift
    ;;
--toggle)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    pactl get-sink-mute @DEFAULT_SINK@ | grep yes >/dev/null && echo false || echo true
    shift
    ;;
*)
    echo false
    shift
    ;;
esac
