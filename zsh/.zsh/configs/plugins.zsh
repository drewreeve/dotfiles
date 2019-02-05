#
# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
# ...........................................................................

function() {
  local pkgpath="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

  # Prefer arch package if it's available
  if [[ -r $pkgpath ]]; then
    source $pkgpath
  else
    if [ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
      source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
  fi
}


#
# zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
# ...........................................................................

function() {
  local pkgpath="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

  if [[ -r $pkgpath ]]; then
    source $pkgpath
  else
    if [ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ];
    then
      source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
  fi
}
