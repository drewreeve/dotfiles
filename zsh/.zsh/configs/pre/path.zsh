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
