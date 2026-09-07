status is-interactive; or return

if type -q atuin
  # Keep fish's own up-arrow history; atuin still owns ctrl-r
  atuin init fish --disable-up-arrow | source
end
