#
# Prompt configuration
#

# Allow colors to be specified by name
autoload -Uz colors && colors

# Initialize prompt system
autoload -Uz promptinit; promptinit

# If starship is installed just use that, otherwise use a fallback
if (($+commands[starship])); then
  eval "$(starship init zsh)"
else
  # Set prompt theme
  prompt simples
fi
