starship init fish | source
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1

## Export variable need for qt-theme
if type qtile >>/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --hidden --max-depth 5
set fzf_git_log_format "%H %s"
set fzf_diff_highlighter diff-so-fancy
set fzf_history_time_format %d-%m-%y
set FZF_COMPLETE 3
set -U FZF_LEGACY_KEYBINDINGS 0
set FZF_CTRL_R_OPTS "--style minimal --scheme=history --layout=reverse --preview-window hidden"
set FZF_DEFAULT_OPTS (echo "
    --style full --padding 1,2 --info=inline --border --margin=1 \
    --input-label ' Search ' --layout=reverse \
    --preview-window 'wrap,60%'  \
    --preview 'fzf-preview {}' \
    --color='border:#aaaaaa,label:#cccccc' \
    --color='preview-border:#9999cc,preview-label:#ccccff' \
    --color='list-border:#669966,list-label:#99cc99' \
    --color='input-border:#996666,input-label:#ffcccc' \
    --color='header-border:#6699cc,header-label:#99ccff'
")
fzf --fish | source

## Advanced command-not-found hook
# source /usr/share/doc/find-the-command/ftc.fish
#
## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

bind ctrl-f 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
bind ctrl-g 'set old_tty (stty -g); stty sane; _fzf_jump; stty $old_tty; commandline -f repaint'
bind ctrl-O 'set old_tty (stty -g); stty sane; _rfv; stty $old_tty; commandline -f repaint'

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function cp
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

function find_git --description="find .git in the parent dir of given path"
    # Input file path
    if test (count $argv) -eq 0
        return 0
    end

    # Input file path from the argument
    set input_file $argv[1]

    # Get the parent directory of the input file
    set parent_dir (dirname "$input_file")

    # Traverse up the directory tree to find the .git directory
    while test "$parent_dir" != / && test "$parent_dir" != "."
        if test -d "$parent_dir/.git"
            echo "$parent_dir"
            return 0
        end
        set parent_dir (dirname "$parent_dir")
    end
    echo $(dirname "$input_file")
end

function _rfv --wraps="nvim" --description="vi with fzf+ripgrep if argv is empty"
    if test (count $argv) -eq 0
        set result $(rfv | tr " " "\n")
        if test (count $result) -ne 0 && test $result[1] != ""
            set file_path "$result[1]"
            set git_path $(find_git "$file_path")
            if test -d "$git_path"
                cd "$git_path"
                if test $git_path = "."
                    set open_path "$file_path"
                else
                    set open_path (string replace --regex "$git_path/" "" $file_path)
                end
                nvim "./$open_path" "+$result[2]"
            end
            return 0
        end
        return 0
    else
        nvim $argv
    end
end

function vi --wraps="nvim" --description="vi with fzf if argv is empty"
    if test (count $argv) -eq 0
        set result $(fd . $1 --hidden 2>/dev/null | fzf --border-label ' Jump ' --preview-window 'wrap,60%,up')
        if test $result && test $result != ""
            set file_path "$result"
            set git_path $(find_git "$file_path")
            if test -d "$git_path"
                cd "$git_path"
                if test $git_path = "."
                    set open_path "$file_path"
                else
                    set open_path (string replace --regex "$git_path/" "" $file_path)
                end
                nvim "./$open_path"
            end
            return 0
        end
        return 0
    else
        nvim $argv
    end
end
bind ctrl-o 'set old_tty (stty -g); stty sane; vi; stty $old_tty; commandline -f repaint'

function _fzf_jump
    set target $(fd . $1 --hidden 2>/dev/null | fzf --border-label ' Jump ' --preview-window 'wrap,60%,up')
    if test "$target" != ""
        if test -d $target
            cd $target
        else
            cd $(dirname $target)
        end
    end
end

# set -x MANPAGER 'manpager '

## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.='exa -ald --color=always --group-directories-first --icons .*' # show only dotfiles
alias ip='ip -color'
alias man=manpager

# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes'

[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
alias hw='hwinfo --short' # Hardware Info

alias tb='nc termbin.com 9999'
alias lg='lazygit'
alias Env='source .env/bin/activate.fish'
alias Eenv='source env/bin/activate.fish'
alias Dnv='deactivate'
alias Cenv='virtualenv .env'
alias ..='cd ..'
alias ...='cd ../..'
alias gcf='cd $HOME/.config'
alias gdl='cd $HOME/Downloads'
alias install='sudo xbps-install -S'
alias update='sudo xbps-install -Suy'
alias remove='sudo xbps-remove -Oo'
alias l='exa -ll --color=always --group-directories-first'
alias df='df -h'
alias free='free -h'
# Dotfiles & Files
alias gc="git clone"
alias reboot="loginctl reboot"
alias wttr="curl wttr.in"

# Cleanup orphaned packages
alias cleanup='sudo xbps-remove -Oo'

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

## Alias Custom SSH
alias antwall="ssh -i ~/.ssh/bangmodp jakkaphat.j@10.100.254.23"
alias antnalytics="ssh -i ~/.ssh/bangmodp jakkaphat.j@10.100.8.30"
alias antwallt="ssh -i ~/.ssh/bangmodp jakkaphat.j@10.100.254.25"

function kitty-reload
    kill -SIGUSR1 $(pidof kitty)
end

function fish_greeting
    clear
end
