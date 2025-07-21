stty -ixon # Disables ctrl-s and ctrl-q (Used To Pause Term)

set -o vi
# PS1 Customization
export PROMPT_DIRTRIM=6

# PS1="\[\e[m\]\[\e[34m\]\u\[\e[m\] \W "
                                      
bind "set show-mode-in-prompt on"
bind 'set vi-cmd-mode-string "\1\e[0;32m\2[N]\1\e[0m\2"'
bind 'set vi-ins-mode-string "\1\e[0;31m\2[I]\1\e[0m\2"'
# bind 'let &t_SI="\e[5 q"'
# bind 'let &t_EI="\e[2 q"'

# set editing-mode vi

bind TAB:menu-complete
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

# bind '"\e[A":history-search-backward'
# bind '"\e[B":history-search-forward'

# Keep Ctrl-Left and Ctrl-Right working when the above are used
# bind '"\e[1;5C":forward-word'
# bind '"\e[1;5D":backward-word'
