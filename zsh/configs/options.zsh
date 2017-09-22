#
# Zsh options/settings
#

setopt AUTO_PUSHD           # Push old directory onto stack on cd
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack
setopt PUSHD_SILENT         # Do not print directory stack after pushd/popd
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given
setopt PUSHD_MINUS

DIRSTACKSIZE=5

# Magic urls
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
