# Dotfiles

My collection of dotfiles for all the apps I use. I like to experiment with
things a lot so I tend to update them pretty frequently.

![screenshot](http://imgh.us/dotfiles.png)

## Requirements

Set zsh as your login shell:

    chsh -s $(which zsh)

## Installation

    git clone https://github.com/drewreeve/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    make

The makefile by default will do the following:

* Install [Stow](https://www.gnu.org/software/stow/) via brew/apt/pacman
* Stow (symlink) everything into **~/** (it won't replace existing files)
* Install [vim-plug](https://github.com/junegunn/vim-plug) and a [selection of plugins](https://github.com/drewreeve/dotfiles/tree/master/vim/.vim/rcplugins)
* Install [asdf](https://github.com/asdf-vm/asdf) along with the ruby and nodejs plugins

## Notes

#### TrueColor

I don't know of a way to check if a terminal app supports true color or not. So
instead, if your terminal supports truecolor you can create an empty
`.true_color` file in your home directory:

    touch ~/.true_color

Then all of the relevant options in neovim/vim/tmux are set. You'll need tmux
2.1+ and neovim or a recent version of vim for full support.

#### Colorscheme

I use [gruvbox](https://github.com/morhetz/gruvbox) in vim and in my terminal.
You can find gruvbox colors for most terminals/apps in the [gruvbox-contrib](https://github.com/morhetz/gruvbox-contrib) repo.

#### Font
I use [Fira Mono](https://github.com/mozilla/Fira) a great open source font from mozilla.


## Inspiration

* [thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles)
* [hashrockets dotfiles](https://github.com/hashrocket/dotmatrix)
* [ohmyzsh](https://github.com/robbyrussell/oh-my-zsh)
* [prezto](https://github.com/sorin-ionescu/prezto)
