FILE="bash"
if [ "$ZSH_VERSION" ]; then
    FILE="zsh"
elif [ "$BASH_VERSION" ]; then
    FILE="bash"
fi
# Use bash-completion, if available
[[ $PS1 && $BASH_VERSION && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

[[ $PS1 && -f "/usr/share/fzf/key-bindings.$FILE" ]] &&
    source "/usr/share/fzf/key-bindings.$FILE"

[[ $PS1 && -f "/usr/share/fzf/completion.$FILE" ]] &&
    source "/usr/share/fzf/completion.$FILE"
