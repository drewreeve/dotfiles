#
# zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
# ...........................................................................

if [[ "$(uname)" == "Darwin" ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/{,zsh/plugins/}zsh-syntax-highlighting/zsh-syntax-highlighting.zsh(N)
fi