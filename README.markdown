Installation:

    git clone git://github.com/flux/dotfiles.git ~/.dotfiles

Create symlinks:

    ln -nfs ~/.dotfiles/bin ~/bin
    ln -nfs ~/.dotfiles/zshrc ~/.zshrc
    ln -nfs ~/.dotfiles/gitignore ~/.gitignore
    ln -nfs ~/.dotfiles/tm_properties ~/.tm_properties
    ln -nfs ~/.dotfiles/gemrc ~/.gemrc
    ln -nfs ~/.dotfiles/irbrc ~/.irbrc
    ln -nfs ~/.dotfiles/vim ~/.vim
    ln -nfs ~/.dotfiles/vimrc ~/.vimrc
    ln -nfs ~/.dotfiles/gvimrc ~/.gvimrc

Create vim-tmp directory for vim swp files:

    mkdir ~/vim-tmp

Make git-cwd-info executable:

    chmod +x ~/bin/git-cwd-info
