# load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

# Source files from specified directory
# Checks for pre & post directories and loads them in the correct order

# Borrowed from the excellent thoughtbot dotfiles
# http://github.com/thoughtbot/dotfiles
_load_settings() {
  _dir="$1"

  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      # Restrict to regular files/symlinks. Expands to empty list if no match
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      if [[ "$config" =~ "^$_dir?\/(pre|post)" ]]; then
        continue
      elif [ -f $config ]; then
        . $config
      fi
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}

# Load additional files from ~/.zsh
_load_settings $HOME/.zsh/configs

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
