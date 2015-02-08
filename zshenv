export EDITOR=vim

# Load dotfiles .bin directory first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - zsh --no-rehash)"
fi

# Use Tim Pope's trick for adding binstubs to your $PATH
# mkdir .git/safe in the root of trusted repos
export PATH=".git/safe/../../bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
