# Options/environment settings

#
# Paths
#

# Remove duplicates from path arrays
typeset -gU cdpath fpath mailpath path

# Treat `#`, `~`, and `^` as patterns for filename globbing.
setopt EXTENDED_GLOB

path=(
  $HOME/.local/bin
  /usr/local/{bin,sbin}
  $path
)
# Remove any paths that don't exist
path=($^path(N))

fpath+=${ZDOTDIR:-$HOME/.config/zsh}/functions

#
# History
#

# Borrowed from prezto
# https://github.com/sorin-ionescu/prezto/blob/master/modules/history/init.zsh

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"  # Path to history file
HISTSIZE=10000                             # Internal history size
SAVEHIST=$HISTSIZE                         # Max events to store in history file

#
# Environment Variables
#

# Editor
if (($+commands[nvim])); then
  export VISUAL=nvim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL

# Set input mode
bindkey -e

# Allow colors to be specified by name
autoload -Uz colors && colors
