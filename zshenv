export EDITOR=vim

# Load dotfiles bin directory first
path=(
  $HOME/bin
  /usr/local/sbin
  $path
)

if command -v chruby-exec >/dev/null; then
  if (( $+commands[chruby-exec] )); then
    source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
    source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"
    chruby_auto
  fi
fi

autoload -Uz add-zsh-hook

function add_trusted_bin_to_path() {
  if [[ -n TRUSTED_BIN_DIR ]]; then
    path=(${path:#$TRUSTED_BIN_DIR})
    unset TRUSTED_BIN_DIR
  fi
  if [[ -d "${PWD}/.git/safe" ]]; then
    TRUSTED_BIN_DIR="${PWD}/bin"
    path=($TRUSTED_BIN_DIR $path)
  fi
}

add-zsh-hook preexec add_trusted_bin_to_path
add_trusted_bin_to_path

# Remove duplicate paths
typeset -U path

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
