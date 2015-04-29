export EDITOR=vim

# Load dotfiles bin directory first
path=(
  $HOME/bin
  /usr/local/sbin
  .git/safe/../../node_modules/.bin
  $path
)

if command -v chruby-exec >/dev/null; then
  if (( $+commands[chruby-exec] )); then
    source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
    source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"
    chruby_auto
  fi
fi

# Source trusted_bin_dir now that chruby is loaded so that our trusted path
# gets appended in front of chrubys
source $HOME/.zsh/trusted_bin_dir.zsh

# Remove duplicate paths
typeset -U path

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
