status is-interactive; or return

if type -q fzf
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

  # Set up fzf key bindings
  fzf --fish | source
end
