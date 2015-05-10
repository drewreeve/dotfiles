export EDITOR=vim

# Load dotfiles bin directory first
path=(
  $HOME/bin
  /usr/local/sbin
  .git/safe/../../bin
  .git/safe/../../node_modules/.bin
  $path
)

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - zsh --no-rehash)"
fi

# Remove duplicate paths
typeset -U path

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
