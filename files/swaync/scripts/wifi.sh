#!/usr/bin/env -S bash

wifi_state=$(nmcli radio wifi)

case $1 in
--check)
  if [ "$wifi_state" == "enabled" ]; then echo true 
  else echo false; fi
  break 
  ;;
--toggle)
  if  [ "$wifi_state" == "enabled" ]; then 
    nmcli radio wifi off 
    echo false
  else 
    nmcli radio wifi on 
    echo true
  fi
  break 
  ;;
*)
  echo false
  ;;
esac

