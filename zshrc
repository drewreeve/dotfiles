# Load additional files from zsh directory
for config in ~/.zsh/*; do
  source $config
done

autoload -U compinit
compinit

# Completions
setopt always_to_end
setopt complete_in_word

## Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
## Use arrows to navigate completion options
zstyle ':completion:*:*:*:*:*' menu select

# Corrections
setopt correct

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

# Quote pasted URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Use vim as editor
export EDITOR=vim

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Add colors to grep/ls
autoload -U colors
colors
export GREP_OPTIONS="--color"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# Add Paths
export PATH=$HOME/.bin:$PATH

## rbenv  https://github.com/sstephenson/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Setup prompt
setopt prompt_subst
local lastcmdstatus="%(?,%{$fg[green]%}→%{$reset_color%},%{$fg[red]%}→%{$reset_color%})"

PROMPT='
%~
${lastcmdstatus} %{$reset_color%}'

RPROMPT='%{$fg[white]%}$(git_info)%{$reset_color%}'

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
