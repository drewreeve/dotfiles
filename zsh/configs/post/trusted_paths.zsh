# Prepend node and bundler binstubs to path in trusted repositories
# Use git trust or mkdir .git/safe to mark a repository as trusted

function _add_trusted_local_bin_to_path() {
  path[1,0]=.git/safe/../../node_modules/.bin
  path[1,0]=.git/safe/../../bin
}

_add_trusted_local_bin_to_path

# Complete trusted binstubs
zstyle -e ':completion:*' command-path '[[ -d $PWD/.git/safe/../../bin ]] && reply=($PWD/bin $PATH)'

# If we're using chruby we have to redo setting this path since changing
# rubies will place the new ruby path before our binstubs


if (($+commands[chruby-exec])); then
  if [[ ! "$preexec_functions" == *_add_trusted_local_bin_to_path* ]]; then
    preexec_functions+=("_add_trusted_local_bin_to_path")
  fi
fi
