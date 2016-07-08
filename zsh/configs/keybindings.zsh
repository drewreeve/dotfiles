bindkey -e

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey "^[[3~" delete-char
bindkey "^K" kill-line

# ctrl+t to find file and copy path
bindkey "^T" _fzf-file-widget
