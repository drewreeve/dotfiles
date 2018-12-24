#
# Setup fzf
#

path+=(~/.fzf/bin(N))

if (($+commands[fzf])); then
  # Use fd for default command if it's available
  if (($+commands[fd])); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
    return
  fi

  # Use rg for default command if it's available
  if (($+commands[rg])); then
    export FZF_DEFAULT_COMMAND='rg --hidden --files'
  fi
fi
