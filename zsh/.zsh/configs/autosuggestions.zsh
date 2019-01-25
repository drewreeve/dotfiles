# Source zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions

pkgpath="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Prefer arch package if it's available
if [[ -r $pkgpath ]]; then
  source $pkgpath
  return
fi

if [ -f ~/.zsh/autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh
fi
