# Don't automatically activate mise as it causes homebrew paths to move
# ahead of the mise ones. Must be a universal variable as otherwise the
# vendor script gets loaded before this file sets the variable
set -Ux MISE_FISH_AUTO_ACTIVATE 0 

# Disable greeting
set -g fish_greeting

# Configure homebrew

if test -e /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

# Configure $PATH
fish_add_path --global \
  $HOME/.local/bin \
  $HOME/.cargo/bin


if type -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
end
