#
# Runs at login post zshrc
#

# Taken from prezto http://gitub.com/sorin-ionescu/prezto
# Execute code that does not affect the current session in the background
{
  # Compile the completion dump to increase startup speed.
  zcompdump="$HOME/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!
