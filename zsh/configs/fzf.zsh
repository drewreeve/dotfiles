#
# Setup fzf
#

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Use ag for default command if it's available
if (($+commands[ag])); then
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi

# rebind ctrl+r to builtin history search instead of fzf's
bindkey "^R" history-incremental-search-backward
