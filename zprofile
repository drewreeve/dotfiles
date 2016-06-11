# Executes commands at login before zshrc

#
# Path
#

# Remove duplicates from path arrays
typeset -gU cdpath fpath mailpath path

# Setup path. Also add rbenv bin dir in case it was cloned instead of
# using a package manager. It'll get removed next if it doesn't exist.
path=(
  $HOME/bin
  $HOME/.rbenv/bin
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
