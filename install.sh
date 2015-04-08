#!/usr/bin/env zsh

set -e

dotfiles_dir="$(cd "${0%/*}"; pwd)"
skip=("README.markdown" "install.sh")

for file in "$dotfiles_dir"/*; do
  name="$(basename "$file")"
  [[ $name = bin ]] && dotname="$name" || dotname=".${name}"

  if (($skip[(Ie)$name])); then
    echo "Skipping: $name"
    continue
  else
    ln -sfnv ${file} "${HOME}/${dotname}"
  fi
done

if [ ! -e ~/.vim-tmp ]; then
  echo "Creating ~/.vim-tmp folder"
  mkdir ~/.vim-tmp
fi

if [ ! -e ~/.vim/bundle/vundle ]; then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

vim -u ~/.vimrc.bundles +PluginInstall +PluginClean! +qa
