#
# Setup fzf
#

path+=(~/.fzf/bin(N))

if (($+commands[fzf])); then
  # Use ag for default command if it's available
  if (($+commands[ag])); then
    export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
  fi
fi
