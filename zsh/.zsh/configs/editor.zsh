if (($+commands[nvim])); then
  export VISUAL=nvim
else
  export VISUAL=vim
fi

export EDITOR=$VISUAL
