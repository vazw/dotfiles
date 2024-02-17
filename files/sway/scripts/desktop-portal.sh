#!/usr/bin/bash

# Xdg DEsktop Portal

if [[ ! $(pidof xdg-desktop-portal-wlr) ]]; then
    .//usr/libexec/xdg-desktop-portal-wlr &
else
    pkill xdg-desktop-portal-wlr 
    .//usr/libexec/xdg-desktop-portal-wlr &
fi

if [[ ! $(pidof xdg-desktop-portal) ]]; then
    .//usr/libexec/xdg-desktop-portal &
else
    pkill xdg-desktop-portal 
    .//usr/libexec/xdg-desktop-portal &
fi
