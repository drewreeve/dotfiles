# Remove duplicates from path arrays
typeset -gU cdpath fpath mailpath path

fpath=($fpath $HOME/.zsh/autoload)

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day. From: http://github.com/sorin-ionescu/prezto
autoload -Uz compinit

function () {
  if [[ -o noextendedglob ]]; then
    setopt EXTENDED_GLOB local_options
  fi

  local _comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
  if (( $#_comp_files )); then
    compinit -i -C
  else
    compinit -i
  fi
}

# Allow colors to be specified by name
autoload -Uz colors && colors

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

# Initialize prompt system
autoload -Uz promptinit; promptinit

# Prompt theme
prompt simples

# Specify emacs keymap by default
# NOTE: This has to be set before input.zsh is loaded
bindkey -e
