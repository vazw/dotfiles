export FZF_COMPLETE=3
export FZF_LEGACY_KEYBINDINGS=0
export FZF_CTRL_R_OPTS="
  --preview 'echo {2..} | bat --color=always -pl sh'
  --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-t:track+clear-query'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_DEFAULT_OPTS="
  --style full --padding 1,2 --info=inline --border --margin=1 
  --input-label ' Search ' --layout=reverse 
  --preview-window 'up,wrap,60%'  
  --preview 'fzf-preview {}' 
  --color='border:#aaaaaa,label:#cccccc' 
  --color='preview-border:#9999cc,preview-label:#ccccff' 
  --color='list-border:#669966,list-label:#99cc99' 
  --color='input-border:#996666,input-label:#ffcccc' 
  --color='header-border:#6699cc,header-label:#99ccff'"
# --layout=reverse
# Lf file manager
export PATH_ESCAPE='s/ /\ /g;s/\\/\\\\/g;s/"/\\"/g'

[ "$ZSH_VERSION" ] && eval "$(fzf --zsh)"
[ "$BASH_VERSION" ] && eval "$(fzf --bash)"
