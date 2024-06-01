#
# Aliases
#

alias e="$EDITOR"

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

# Bat https://github.com/sharkdp/bat
if (($+commands[bat])); then
  alias cat='bat'
fi

# Read/write variable from ansible playbook
avar() {
  __avar_error() {
    \cat >&2 <<'EOF'
Usage: avar [action] [variable name]

Actions:
  r, read       Read value of variable
  e, encrypt    Encrypt stdin string as variable

Example:
  avar r secret    Print the value of the 'secret' variable
  avar e secret    Encrypt string from stdin and name it 'secret'
EOF
  }

  if [[ -v 1 ]] && [[ -v 2 ]]; then
    case "$1" in
      r | read )
        ansible localhost -m debug -a var="$2";;
      e | encrypt )
       ansible-vault encrypt_string  --stdin-name "$2";;
      *)
        __avar_error
    esac
  else
    __avar_error
  fi
  unset -f __avar_error
}

# Load machine specific aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
