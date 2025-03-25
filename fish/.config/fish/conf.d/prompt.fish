status is-interactive; or return

# Use starship prompt if installed
if type -q starship
  starship init fish | source
end
