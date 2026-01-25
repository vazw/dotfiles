#!/usr/bin/env bash  

PORTALS_REGISTERED=$(dbus-send --print-reply --dest=org.freedesktop.DBus  /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep -c -E '(portal.Desktop|impl.portal.desktop.wlr)')


# Won't kill screencast process when refreshing sway while recording  
if [ "$PORTALS_REGISTERED" -lt 2 ]; then
  pidof xdg-desktop-portal | xargs kill
  pidof xdg-desktop-portal-wlr | xargs kill
  sleep 2

  sh -c /usr/libexec/xdg-desktop-portal &
  sleep 1
  sh -c /usr/libexec/xdg-desktop-portal-wlr
fi
