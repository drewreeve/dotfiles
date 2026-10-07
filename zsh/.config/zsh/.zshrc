#
# Paths
#

# Remove duplicates from path arrays
typeset -gU path fpath

path=(
  $HOME/.local/bin
  /opt/{homebrew,local}/{,s}bin(N)
  $HOME/.cargo/bin(N)
  $path
)

fpath+=(
  /opt/homebrew/share/zsh/site-functions(N)
  /opt/homebrew/share/zsh-completions(N)
  $ZDOTDIR/functions
)

autoload -Uz extract

# Load homebrew shellenv, but only 'HOMEBREW_' variables
if (( $+commands[brew] )); then
  eval "${(@M)${(f)"$(brew shellenv 2> /dev/null)"}:#export HOMEBREW*}"
fi

#
# Options
#

setopt EXTENDED_GLOB        # Treat `#`, `~`, and `^` as patterns (also used by compinit below).
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
setopt PATH_DIRS            # Perform path search even on command names with slashes.
unsetopt FLOW_CONTROL       # Disable start/stop characters in shell editor.

#
# History
#

setopt EXTENDED_HISTORY     # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY        # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_VERIFY          # Do not execute immediately upon history expansion.

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE

alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

#
# Environment
#

if (( $+commands[nvim] )); then
  export VISUAL=nvim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL

#
# Keys
# Based on https://github.com/zimfw/input
#

# Emacs mode. Required, as zsh picks vi mode when $EDITOR contains "vi".
bindkey -e

if [[ $TERM != dumb ]]; then
  zmodload -F zsh/terminfo +b:echoti +p:terminfo

  () {
    local key
    for key in '\e[1;5D' '\e[5D' '\e\e[D' '\eOd'; do bindkey $key backward-word; done
    for key in '\e[1;5C' '\e[5C' '\e\e[C' '\eOc'; do bindkey $key forward-word; done
  }

  bindkey '^?' backward-delete-char
  bindkey '^[[3~' delete-char
  [[ -n $terminfo[khome] ]] && bindkey $terminfo[khome] beginning-of-line
  [[ -n $terminfo[kend] ]] && bindkey $terminfo[kend] end-of-line
  [[ -n $terminfo[kpp] ]] && bindkey $terminfo[kpp] up-line-or-history
  [[ -n $terminfo[knp] ]] && bindkey $terminfo[knp] down-line-or-history
  [[ -n $terminfo[kich1] ]] && bindkey $terminfo[kich1] overwrite-mode
  [[ -n $terminfo[kcbt] ]] && bindkey $terminfo[kcbt] reverse-menu-complete

  # Expand history (e.g. !!) on space
  bindkey ' ' magic-space

  # <Ctrl-x><Ctrl-e> to edit command-line in $EDITOR
  autoload -Uz edit-command-line && zle -N edit-command-line
  bindkey '^X^E' edit-command-line

  # Quote URLs when typed or pasted
  autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

  # Enable application mode while zle is active so $terminfo key codes match
  if (( $+terminfo[smkx] && $+terminfo[rmkx] )); then
    zle-app-mode-start() { echoti smkx }
    zle-app-mode-stop() { echoti rmkx }
    autoload -Uz add-zle-hook-widget
    add-zle-hook-widget line-init zle-app-mode-start
    add-zle-hook-widget line-finish zle-app-mode-stop
  fi
fi

#
# Terminal title
#

if [[ $TERM != dumb ]]; then
  termtitle_precmd() {
    case $TERM in
      screen*) print -Pn '\ek%n@%m: %~\e\\' ;;
      *) print -Pn '\e]0;%n@%m: %~\a' ;;
    esac
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd termtitle_precmd
fi

#
# Completion
#

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day. Borrowed from https://github.com/sorin-ionescu/prezto
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check).
  compinit -C -d "$_comp_path"
else
  mkdir -p "$_comp_path:h"
  compinit -i -d "$_comp_path"
  # Keep $_comp_path younger than cache time even if it isn't regenerated.
  touch "$_comp_path"
fi
unset _comp_path

# Caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Menu, grouping and descriptions
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'

# Case-insensitive, then partial-word matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|?=**'
zstyle ':completion:*' squeeze-slashes true

# Ignore internal functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'
# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order 'indexes' 'parameters'

# Don't offer files already on the line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

#
# Prompt
#

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  autoload -Uz promptinit && promptinit
  prompt simples
fi

#
# Tools
#

(( $+commands[mise] )) && eval "$(mise activate zsh)"
# Must come after compinit
(( $+commands[zoxide] )) && eval "$(zoxide init --cmd cd zsh)"

#
# Aliases
#

alias e="$EDITOR"

if (( $+commands[dircolors] )); then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi
alias ll='ls -lh'
alias la='ll -A'

alias grep='grep --color=auto'
alias ppath='print -l $path'

(( $+commands[bat] )) && alias cat='bat'

#
# Plugins
# Syntax highlighting must be sourced last.
#

for _plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  for _file in {/opt/homebrew,/usr}/share/$_plugin/$_plugin.zsh /usr/share/zsh/plugins/$_plugin/$_plugin.zsh; do
    [[ -r $_file ]] && { source $_file; break }
  done
done
unset _plugin _file

#
# Local config
#

[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
