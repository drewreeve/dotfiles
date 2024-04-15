# ASDF version manager
# https://github.com/asdf-vm/asdf

if (( ! ${+ASDF_DIR} )); then
  for ASDF_DIR in \
      {/usr/local,/opt/homebrew,/home/linuxbrew/.linuxbrew}/opt/asdf/libexec \
      /opt/asdf-vm \
      ${HOME}/.asdf
  do
    if [[ -e ${ASDF_DIR} ]] break
  done
fi
export ASDF_DIR

if [ -d "$ASDF_DIR" ]; then
  source "$ASDF_DIR/asdf.sh"

  if [[ "$ASDF_DIR" == "$HOME/.asdf" ]]; then
    fpath+=("$ASDF_DIR/completions"(FN))
  fi
fi

# Return if asdf not found
if (( ! $+commands[asdf])); then
  return 1
fi

# Borrowed from https://github.com/junegunn/fzf/wiki/Examples#asdf

# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf install $lang $version; done;
    fi
  fi
}

# Remove one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf uninstall $lang $version; done;
    fi
  fi
}
