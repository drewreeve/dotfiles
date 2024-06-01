# https://github.com/ajeetdsouza/zoxide
# zoxide is a smarter cd command, inspired by z and autojump.

if (($+commands[zoxide])); then
  eval "$(zoxide init --cmd cd zsh)"
fi
