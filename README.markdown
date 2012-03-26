Installation:

    git clone git://github.com/flux/dotfiles.git ~/.dotfiles

Create symlinks:

    ln -nfs ~/.dotfiles/bin ~/bin
    ln -nfs ~/.dotfiles/zsh/zshrc ~/.zshrc
    ln -nfs ~/.dotfiles/gitignore ~/.gitignore
    ln -nfs ~/.dotfiles/tm_properties ~/.tm_properties
    ln -nfs ~/.dotfiles/gemrc ~/.gemrc
    ln -nfs ~/.dotfiles/irbrc ~/.irbrc

Make git-cwd-info executable:

    chmod +x ~/bin/git-cwd-info