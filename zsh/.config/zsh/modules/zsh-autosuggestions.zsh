#
# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
# ...........................................................................

if [[ "$(uname)" == "Darwin" ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source /usr/share/{,zsh/plugins/}zsh-autosuggestions/zsh-autosuggestions.zsh(N)
fi