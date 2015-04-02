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
