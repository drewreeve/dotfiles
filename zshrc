# Load additional files from zsh directory
for config in ~/.zsh/*; do
  source $config
done

# Completions
autoload -U compinit
compinit -i

setopt always_to_end
setopt complete_in_word

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
# Complete binstubs
zstyle -e ':completion:*' command-path '[[ -d $PWD/.git/safe/../../bin ]] && reply=($PWD/bin $PATH)'

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

# Keybindings
bindkey -e
# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Add colors to grep/ls
autoload -U colors
colors
export CLICOLOR=1
export GREP_OPTIONS="--color"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
