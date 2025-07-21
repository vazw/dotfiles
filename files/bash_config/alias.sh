# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias gcf='cd $HOME/.config'
alias gdl='cd $HOME/Downloads'
# alias install='sudo xbps-install -S'
alias update='sudo xbps-install -Su'
alias remove='sudo xbps-remove'
alias cleanup='sudo xbps-remove -Oo'

alias ll='ls --group-directories-first -l --color=always '
alias ls='ls --group-directories-first --color=always'
alias df='df -h'
alias free='free -h'
# Dotfiles & Files
alias bs='nvim ~/.bashrc'
alias reload='source ~/.bashrc'
alias v="nvim"
alias vv="nvim ~/.config/nvim/init.vim"
alias vi="nvim"
alias ip="ip -c"

alias gc="git clone"
alias lg='lazygit'

alias reboot="loginctl reboot"
alias Cenv="python -m venv .venv"
alias Env="source .venv/bin/activate"
alias Dnv="deactivate"

alias ipa="ip -c a"
alias untar='tar -xvf '
alias wd-reboot="sudo waydroid container restart"
# Add Color
alias egrep='grep --color=auto'

rvi () {
  nvim --server ~/.cache/nvim/server.pipe --remote-send ":cd $(pwd)<CR>"
  nvim --server ~/.cache/nvim/server.pipe --remote "$1"
  nvim --server ~/.cache/nvim/server.pipe --remote-ui
}

cd () {
  command cd "$@" && ls
}
