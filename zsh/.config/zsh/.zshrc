foreach file (
  environment.zsh
  input.zsh
  history.zsh
  title.zsh
  homebrew.zsh
  prompt.zsh
  asdf.zsh
  fzf.zsh
  extract.zsh
  aliases.zsh
  keybinds.zsh
  completions.zsh
  zoxide.zsh
  zsh-syntax-highlighting.zsh
  zsh-autosuggestions.zsh
) {
  source "$ZDOTDIR/modules/$file"
}
unset file

# Local config
if [[ -s ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
