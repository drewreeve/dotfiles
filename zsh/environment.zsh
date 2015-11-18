#
# Set general shell options and variables here
#

#
# Magic urls
#

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Keybinds
#

bindkey -e
# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey "^[[3~" delete-char
bindkey "^K" kill-line
