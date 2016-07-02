#
# rbenv
#

# add rbenv bin dir in case it was cloned instead of using a package manager
path[${path[(i)$HOME/bin]}]+=($HOME/.rbenv/bin(N))

if (($+commands[rbenv])); then
  eval "$(rbenv init - --no-rehash)"
  return
fi

#
# chruby
#

if (($+commands[chruby-exec])); then
  source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
  source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"
fi
