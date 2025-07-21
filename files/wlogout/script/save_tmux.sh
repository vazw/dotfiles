#!/bin/bash


TERM=xterm 

save_tmux () {
 bash "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/save.sh" && sleep 2 && notify-send 'Saved tmux session, Have a good day' || notify-send 'Have a good day' 
}

tmux list-session && save_tmux && tmux kill-server
