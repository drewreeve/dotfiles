# load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

foreach file (
  init.zsh
  exports.zsh
  input.zsh
  settings.zsh
  prompt.zsh
  aliases.zsh
  title.zsh
  autosuggestions.zsh
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
