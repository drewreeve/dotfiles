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
  /opt/{homebrew,local}/{,s}bin(N)
  $HOME/.cargo/bin
  /usr/local/{bin,sbin}
  $path
)
# Remove any paths that don't exist
path=($^path(N))

# Add homebrew managed zsh/site-functions if available
fpath+=(/opt/homebrew/share/zsh/site-functions(N))
fpath+=(/opt/homebrew/share/zsh-completions(N))

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

# Some terminfo shenanigans to fix macos not having an up to
# date version of ncurses...
# https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/

function() {
  local ncurses_dir="/opt/homebrew/opt/ncurses"
  local user_terminfo_dir="$HOME/.local/share/terminfo"

  # Don't bother doing this if:
  # - We aren't on macos
  # - There isn't a newer ncurses available via homebrew
  # - Or if tmux-256color is already available
  if [[ "$(uname)" != "Darwin" ]] ||\
    [[ ! -d $ncurses_dir ]] ||\
    /usr/bin/infocmp -x tmux-256color &> /dev/null; then
      return
  fi

  # Export TERMINFO_DIRS if available
  if [[ -d $user_terminfo_dir ]]; then
    export "TERMINFO_DIRS=${TERMINFO_DIRS:+${TERMINFO_DIRS}:}$user_terminfo_dir"
  fi

  # Do nothing else if tmux-256color terminfo exists now
  if /usr/bin/infocmp -x tmux-256color &> /dev/null; then return; fi

  # Copy terminfo from homebrew ncurses and fix pairs value to
  # work with older version of ncurses
  # see: https://github.com/tmux/tmux/issues/2262#issuecomment-719985206
  $ncurses_dir/bin/infocmp -x tmux-256color |
    sed 's|pairs#0x10000|pairs#32767|' > ~/tmux-256color.src

  # Install terminfo to user dir
  /usr/bin/tic -x -o "$user_terminfo_dir" ~/tmux-256color.src
  rm ~/tmux-256color.src

  # Export terminfo
  export "TERMINFO_DIRS=${TERMINFO_DIRS:+${TERMINFO_DIRS}:}$user_terminfo_dir"
}
