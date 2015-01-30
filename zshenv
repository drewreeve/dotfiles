# Load dotfiles .bin directory first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - zsh --no-rehash)"
fi

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
