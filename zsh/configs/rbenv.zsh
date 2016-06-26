#
# Load rbenv if it's available
#

if (($+commands[rbenv])); then
  eval "$(rbenv init - --no-rehash)"
fi
