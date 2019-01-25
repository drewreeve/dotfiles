if (($+commands[nvim])); then
  export VISUAL=nvim
else
  export VISUAL=vim
fi

export EDITOR=$VISUAL

# Set $TERMINAL, this is used by the i3-sensible-terminal script
if (($+commands[alacritty])); then
  export TERMINAL=alacritty
fi
