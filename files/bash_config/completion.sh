# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
	. /usr/share/bash-completion/bash_completion

[[ $PS1 && -f /usr/share/fzf/key-bindings.bash ]] &&
	source /usr/share/fzf/key-bindings.bash

[[ $PS1 && -f /usr/share/fzf/completion.bash ]] &&
	source /usr/share/fzf/completion.bash
