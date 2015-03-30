export EDITOR=vim

# Load dotfiles .bin directory first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

if command -v chruby-exec >/dev/null; then
  if (( $+commands[chruby-exec] )); then
    source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
    source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"
    chruby_auto
  fi
fi

# http://raygrasso.com/posts/2015/02/making-chruby-and-binstubs-play-nice.html
function set_local_bin_path() {
  # Replace any existing local bin paths with our new one
  export PATH="${1:-""}`echo "$PATH"|sed -e 's,[^:]*\.git/[^:]*bin:,,g'`"
}

function add_trusted_local_bin_to_path() {
  if [[ -d "$PWD/.git/safe" ]]; then
    # We're in a trusted project directory so update our local bin path
    set_local_bin_path ".git/safe/../../bin:"
  fi
}

if [[ -n "$ZSH_VERSION" ]]; then
  if [[ ! "$preexec_functions" == *add_trusted_local_bin_to_path* ]]; then
    preexec_functions+=("add_trusted_local_bin_to_path")
    add_trusted_local_bin_to_path
  fi
fi

# Remove duplicate paths
typeset -U PATH

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
