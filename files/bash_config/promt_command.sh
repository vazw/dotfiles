#!/usr/bin/bash

# Import git-prompt
[[ -f "$HOME/.config/bash_config/helper/git-prompt.sh" ]] &&
  . "$HOME/.config/bash_config/helper/git-prompt.sh"

_create_prompt() {
  local EXIT_CODE="$?"
  PS1=""

  [ $EXIT_CODE != 0 ] &&
    PS1+="\[\e[0;33m\][EXIT: $EXIT_CODE]\[\e[0m\]\n"

  PS1_CMD1=$(__git_ps1 " (%s)")
  [ "$PS1_CMD1" == "" ] &&
    PS1+="\[\e[3;32m\]\w\[\e[0m\]\n \$" ||
    PS1+="\W \[\e[0;32m\]${PS1_CMD1}\[\e[0m\]\n \$"

}

PROMPT_COMMAND=_create_prompt 

