if status is-interactive
  # Commands to run in interactive sessions can go here

end

# Source local machine-specific configuration if it exists
if test -f ~/.local.fish
  source ~/.local.fish
end
