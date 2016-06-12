#
# Aliases
#

# ls
if (($+commands[dircolors])); then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

alias ll='ls -lh'
alias la='ll -A'

# Ruby
alias rbh='rbenv rehash'
alias biv='bundle install --path vendor/bundle'
alias migrate="rake db:migrate db:rollback && rake db:migrate db:test:prepare"

# Pretty print path
alias ppath='echo $PATH | tr -s ":" "\n"'

# Grep
alias grep='grep --color=auto'

# Load machine specific aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
