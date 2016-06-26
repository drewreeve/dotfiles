# Prepend node and bundler binstubs to path in trusted repositories
# Use git trust or mkdir .git/safe to mark a repository as trusted

path[1,0]=.git/safe/../../node_modules/.bin
path[1,0]=.git/safe/../../bin

# Complete trusted binstubs
zstyle -e ':completion:*' command-path '[[ -d $PWD/.git/safe/../../bin ]] && reply=($PWD/bin $PATH)'
