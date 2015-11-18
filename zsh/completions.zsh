#
# Set completion options
#

# Add zsh-completions from homebrew to path
fpath=("/usr/local/share/zsh-completions" $fpath)

# Remove paths that don't exist
fpath=($^fpath(N))

autoload -Uz compinit && compinit -i

#
# Options
#

setopt ALWAYS_TO_END # Move cursor to end of completed word
setopt COMPLETE_IN_WORD # Complete a word from either end

# Cache completions
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select
