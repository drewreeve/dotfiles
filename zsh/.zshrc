foreach file (
  init.zsh
  exports.zsh
  input.zsh
  functions.zsh
  keybinds.zsh
  settings.zsh
  aliases.zsh
  title.zsh
  plugins.zsh
  fzf.zsh
  asdf.zsh
  trusted_paths.zsh
) {
  source ~/.zsh/configs/$file
}

# Local config
if [[ -s ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

alias luamake=/home/drew/build/lua-language-server/3rd/luamake/luamake
