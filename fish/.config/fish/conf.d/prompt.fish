status is-interactive; or return

# Use starship prompt if installed, otherwise fish_prompt
if type -q starship
  starship init fish | source
end
