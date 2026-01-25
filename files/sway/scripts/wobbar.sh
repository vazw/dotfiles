#!/usr/bin/sh  

mkfifo "$SWAYSOCK".wob
sleep 1
tail -f "$SWAYSOCK".wob | wob
