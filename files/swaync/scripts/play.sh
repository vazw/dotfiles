#!/bin/bash
if [ "$(swaync-client -D)" = "false" ]; then
    mpv --no-terminal --volume=80 "$HOME/.config/swaync/click.mp3"
fi
