# Executes commands at login before zshrc

#
# Path
#

# Remove duplicates from path arrays
typeset -gU cdpath fpath mailpath path

# Setup path
path=(
  $HOME/bin
  /usr/local/{bin,sbin}
  $path
)

# Remove paths that don't exist
path=($^path(N))

#
# Editor
#

# Set EDITOR to nvim if available, otherwise use vim
if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# Local config
[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local
