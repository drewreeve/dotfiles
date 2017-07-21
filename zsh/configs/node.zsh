#
# Configure a node version manager
#

# nodenv - https://github.com/nodenv/nodenv

# add nodenv bin dir in case it was cloned instead of using a package manager
path[${path[(i)$HOME/bin]}]+=($HOME/.nodenv/bin(N))

if (($+commands[nodenv])); then
  eval "$(nodenv init -)"

# nvm - https://github.com/creationix/nvm
elif [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  source "$HOME/.nvm/nvm.sh"
fi

