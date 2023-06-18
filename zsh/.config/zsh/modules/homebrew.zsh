# Load homebrew shellenv , but only 'HOMEBREW_' variables
if (( $+commands[brew] )); then
  eval "${(@M)${(f)"$(brew shellenv 2> /dev/null)"}:#export HOMEBREW*}"
fi