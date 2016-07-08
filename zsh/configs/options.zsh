#
# Zsh options/settings
#

setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Magic urls
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
