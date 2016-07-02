#
# rbenv
#

# add rbenv bin dir in case it was cloned instead of using a package manager
path[${path[(i)$HOME/bin]}]+=($HOME/.rbenv/bin(N))

if (($+commands[rbenv])); then
  eval "$(rbenv init - --no-rehash)"
fi
