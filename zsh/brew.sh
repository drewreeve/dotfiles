if [ -x "/usr/local/Library" ]; then
  # if zsh-completions is installed add to fpath
  if [ -e "/usr/local/share/zsh-completions" ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
  fi
fi
