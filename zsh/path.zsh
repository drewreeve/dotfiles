# Load dotfiles bin directory first
# Also add rbenv bin dir in case we cloned it there instead of using homebrew
path=(
  $HOME/bin
  $HOME/.rbenv/bin
  /usr/local/sbin
  $path
)

# Remove paths that don't exist
path=($^path(N))

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

# load nvm if available
if [ -d $HOME/.nvm ]; then
  source $HOME/.nvm/nvm.sh
fi

# Prepend node and bundler binstubs to path in trusted repositories
# Use git trust or mkdir .git/safe to mark a repository as trusted
path[1,0]=.git/safe/../../node_modules/.bin
path[1,0]=.git/safe/../../bin

# Remove duplicate paths
typeset -U path

