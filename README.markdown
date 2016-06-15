Requirements
------------

Set zsh as your login shell:

    chsh -s $(which zsh)

Installation
------------

    git clone git://github.com/drewreeve/dotfiles.git ~/.dotfiles
    ~/.dotfiles/install.sh

Notes
-----

**True color**
Rather than trying to detect if tmux, neovim, vim etc support true color I opted
to have a file in my `$HOME` directory called `.true_color`. If that is present
then it's assumed your environment supports true color and all the relevant
options are set.

    touch ~/.true_color
