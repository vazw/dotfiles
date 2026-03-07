# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias gcf='cd $HOME/.config'
alias gdl='cd $HOME/Downloads'
# alias install='sudo xbps-install -S'
alias update='sudo xbps-install -Su'
alias remove='sudo xbps-remove'

alias ls='ls --group-directories-first --color=always'
alias ll='ls -l '
alias la='ls -la '
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

alias cat='bat --style header --style snip --style changes'

alias ipa="ip -c a"
alias untar='tar -xvf '
alias wd-reboot="sudo waydroid container restart"
# Add Color
alias grep='grep --color=auto'

alias prepcam="sudo modprobe v4l2loopback && pkill gphoto"

alias rm='echo "!!!Safty First!! Please Use \`trash-put\` command, or Use \\\rm "; false'

rvi() {
    nvim --server ~/.cache/nvim/server.pipe --remote-send ":cd $(pwd)<CR>"
    nvim --server ~/.cache/nvim/server.pipe --remote "$1"
    nvim --server ~/.cache/nvim/server.pipe --remote-ui
}

cleanup() {
    echo 'Cleaning Up System'
    echo '# sudo xbps-remove -Oo'
    sudo xbps-remove -Oo
    echo '# sudo vkpurge rm all'
    sudo vkpurge rm all
    printf '\nDone\n'
}

clear_cache() {
    echo "Cleaning cache"
    rm -rf ~/.cache/*
    printf '\nDone\n'
}

cd() {
    command cd "$@" && ls
}

export LS_COLORS=$(vivid generate molokai)

alias clamdscan="sudo -u _clamav clamdscan"
