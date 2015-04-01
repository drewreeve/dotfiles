ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll='ls -lG'

alias rbh="rbenv rehash"

alias biv='bundle install --path vendor/bundle'

# Flush dns cache
alias flushdns='dscacheutil -flushcache'

# Load custom aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local

# vim: set syntax=sh:
