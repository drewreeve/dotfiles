status is-interactive; or return

if type -q fzf
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

  # fzf first: it binds ctrl-t, alt-c and ctrl-r
  fzf --fish | source
end

if type -q atuin
  # atuin second so its ctrl-r overrides fzf's history widget.
  # Keep fish's own up-arrow history.
  atuin init fish --disable-up-arrow | source
end
