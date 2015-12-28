#!/usr/bin/env zsh

set -e

dotfiles_dir="$(cd "${0%/*}"; pwd)"
skip=("README.markdown" "install.sh" "termsupport")

for file in "$dotfiles_dir"/*; do
  name="$(basename "$file")"
  dotname=".${name}"

  if (($skip[(Ie)$name])); then
    echo "Skipping: $name"
    continue
  else
    ln -sfnv ${file} "${HOME}/${dotname}"
  fi
done

# Allow nvim to use vim files/folder
ln -sfnv $HOME/.vim $HOME/.config/nvim
ln -sfnv $HOME/.vimrc $HOME/.config/nvim/init.vim

if [ ! -e $HOME/.vim/tmp ]; then
  echo "Creating ~/.vim/tmp folder"
  mkdir -p $HOME/.vim/tmp
fi

if [ ! -e $HOME/.vim/autoload/plug.vim ]; then
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim -u $HOME/.vimrc.bundles +PlugInstall +PlugClean! +qa
