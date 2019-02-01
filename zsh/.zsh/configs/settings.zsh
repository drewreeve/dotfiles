#
# Generic settings
# ...........................................................................

setopt EXTENDED_GLOB        # Needed for file modification glob modifiers

setopt AUTO_PUSHD           # Push old directory onto stack on cd
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack
setopt PUSHD_SILENT         # Do not print directory stack after pushd/popd
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given

# Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify
# a directory in the stack.
setopt PUSHD_MINUS


#
# Completion settings
# ...........................................................................

setopt ALWAYS_TO_END    # Move cursor to end of completed word
setopt COMPLETE_IN_WORD # Complete a word from either end

# A number of these completions are borrowed from these excellent frameworks
# prezto: https://github.com/sorin-ionescu/prezto
# zimfw:  https://github.com/zimfw/zimfw

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|?=**'

# Enable caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"

# Ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Completion sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true


#
# History settings
# ...........................................................................

# Path to history file
HISTFILE=$HOME/.zhistory

# Maximum number of events to store in the internal history and history file
SAVEHIST=10000
HISTSIZE=10000

# Whenever the user enters a line with history expansion, don’t execute the
# line directly; instead, perform history expansion and reload the line
# into the editing buffer.
setopt HIST_VERIFY

# Perform textual history expansion, csh-style, treating the
# character ‘!’ specially.
setopt BANG_HIST

# This option both imports new commands from the history file, and also causes
# your typed commands to be appended to the history file (like specifying
# INC_APPEND_HISTORY). The history lines are also output with timestamps
# ala EXTENDED_HISTORY.
setopt SHARE_HISTORY

# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading space.
setopt HIST_IGNORE_SPACE

# Do not enter command lines into the history list if they are duplicates
# of the previous event.
setopt HIST_IGNORE_DUPS

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list (even if it is not the
# previous event).
setopt HIST_IGNORE_ALL_DUPS

# When writing out the history file, older commands that duplicate newer
# ones are omitted.
setopt HIST_SAVE_NO_DUPS

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates
# are not contiguous.
setopt HIST_FIND_NO_DUPS
