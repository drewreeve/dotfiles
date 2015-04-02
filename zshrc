# Completions
autoload -U compinit
compinit -i

setopt always_to_end
setopt complete_in_word

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select

# Complete trusted binstubs
zstyle -e ':completion:*' command-path '[[ -d $PWD/.git/safe/../../bin ]] && reply=($PWD/bin $PATH)'

# History
HISTFILE=~/.zsh_history # Path to history file
SAVEHIST=10000          # Maximum number of commands to save in history file
HISTSIZE=10000          # Maximum number of commands to save in internal history

# Write history file in ':start:elapsed;command' format
setopt EXTENDED_HISTORY
# Add commands as they're entered, not on shell exit
setopt INC_APPEND_HISTORY
# Do not enter command into history if it duplicates previous command
setopt HIST_IGNORE_DUPS
# If new command duplicates an older one, remove the older one
setopt HIST_IGNORE_ALL_DUPS
# When writing out history file, omit duplicate commands
setopt HIST_SAVE_NO_DUPS
# Do not execute immediately upon history expansion
setopt HIST_VERIFY
# Share history between all sessions
setopt SHARE_HISTORY

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

# Add colors to ls
export CLICOLOR=1

# Load additional files from ~/.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/brew.zsh
source $HOME/.zsh/prompt.zsh
if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  source $HOME/.zsh/terminal_app_cwd_fix.zsh
fi

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
