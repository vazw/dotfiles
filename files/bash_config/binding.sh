stty -ixon # Disables ctrl-s and ctrl-q (Used To Pause Term)

# PS1 Customization
export PROMPT_DIRTRIM=6

bind TAB:menu-complete
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

