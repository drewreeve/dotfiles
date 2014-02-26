# Completion Stuff
setopt correct
setopt complete_in_word
# Can't decide if I prefer this or not...
#setopt MENU_COMPLETE
setopt always_to_end
unsetopt flowcontrol

zmodload -i zsh/complist

autoload -U compinit
compinit -i

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Use arrows to navigate completion options
zstyle ':completion:*' menu select=1

# Aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Load additional files from zsh directory
for config in $HOME/.dotfiles/zsh/*.zsh; do
  source $config
done

# Say how long a command took, if it took more than 10 seconds
export REPORTTIME=10

# Quote pasted URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# History settings
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history

# Make CTRL-W delete after other chars, not just spaces
WORDCHARS=${WORDCHARS//[&=\/;\!#%\{]}

# Fix the delete key
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Use vim as editor
export EDITOR=vim

## PATHS
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.bin:$PATH

# Add npm bin dir to path (per homebrews recommendation)
export PATH="/usr/local/share/npm/bin:$PATH"

## rbenv  https://github.com/sstephenson/rbenv
if [ -d $HOME/.rbenv/bin ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Add colors to grep/ls
autoload -U colors
colors
export GREP_OPTIONS="--color"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# Setup prompts
setopt prompt_subst
local lastcmdstatus="%(?,%{$fg[green]%}→%{$reset_color%},%{$fg[red]%}→%{$reset_color%})"

PROMPT='
%~
${lastcmdstatus} %{$reset_color%}'

RPROMPT='%{$fg[white]%}$(git-cwd-info)%{$reset_color%}'

# vim: set syntax=sh:
