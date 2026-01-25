#!/usr/bin/bash

if [ -n "$EMACS_VTERM_PATH" ]; then
    alias nvim="echo Nop!"
    alias vi="echo Nop!"
elif [ -z "$NVIM" ];then 
    set -o vi
    bind "set show-mode-in-prompt on"
    bind 'set vi-cmd-mode-string "\1\e[0;32m\2[N]\1\e[0m\2"'
    bind 'set vi-ins-mode-string "\1\e[0;31m\2[I]\1\e[0m\2"'
fi

