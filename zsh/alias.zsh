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

# Pretty print path
alias ppath='echo $PATH | tr -s ":" "\n"'

# Grep
alias grep='grep --color=auto'

# Resource use
if (( $+commands[htop] )); then
  alias top=htop
else
  if [[ "$OSTYPE" == (darwin*|*bsd*) ]]; then
    alias topc='top -o cpu'
    alias topm='top -o vsize'
  else
    alias topc='top -o %CPU'
    alias topm='top -o %MEM'
  fi
fi

# List ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Load machine specific aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
