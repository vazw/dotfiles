#!/usr/bin/bash

# Import git-prompt
[[ -f "$HOME/.config/bash_config/helper/git-prompt.sh" ]] &&
  . "$HOME/.config/bash_config/helper/git-prompt.sh"

function __virtualenv_info(){
    if [[ -n "$VIRTUAL_ENV_PROMPT" ]]; then
        venv="${VIRTUAL_ENV_PROMPT##*/}"
        echo " $venv  $(python --version) "
    fi
}


_create_prompt() {
  local EXIT_CODE="$?"
  PS1=""

  [ $EXIT_CODE != 0 ] &&
    PS1+="\[\e[0;33m\][EXIT: $EXIT_CODE]\[\e[0m\]\n\n"

  PS1_CMD1=$(__git_ps1 " (%s)")
  [ "$PS1_CMD1" == "" ] &&
    PS1+="\[\e[3;32m\]\w\[\e[0m\]" ||
    PS1+="\W \[\e[0;32m\]${PS1_CMD1}\[\e[0m\]"

  PS1_CMD2=$(__virtualenv_info)
  [ "$PS1_CMD2" == "" ] ||
    PS1+="\[\e[3;33m\]${PS1_CMD2}\[\e[0m\]"

  PS1+="\n \$"

}

PROMPT_COMMAND=_create_prompt 

