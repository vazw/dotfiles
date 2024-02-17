#!/usr/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## launch dunst with alt config

if [[ ! $(pidof nostr-relay-tray) ]]; then
    nostr-relay-tray &
else
    pkill nostr-relay-tray &
    nostr-relay-tray &
fi
