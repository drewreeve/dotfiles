#
# History
#

HISTFILE=$HOME/.zhistory # Path to history file
SAVEHIST=10000          # Maximum number of commands to save in history file
HISTSIZE=10000          # Maximum number of commands to save in internal history

#
# Options
#

setopt EXTENDED_HISTORY   # Write in ':start:elapsed;command' format
setopt INC_APPEND_HISTORY # Write to history file immediately
setopt HIST_VERIFY        # Do not execute immediately upon history expansion
setopt BANG_HIST          # Treat the '!' character specially during expansion
setopt SHARE_HISTORY      # Share history between all sessions
setopt HIST_IGNORE_SPACE  # Don't record an event starting with a space

# Remove/prevent duplicates
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
