# Dotfiles

My collection of dotfiles for all the apps I use. I like to experiment with
things a lot so I tend to update them pretty frequently.

These dotfiles work well **for me**. While you can feel free to copy anything
you wish, dotfiles are very personal and so where possible you should start 
from scratch yourself and include things which provide value for you.

_Below is a screenshot of my arch machine currently:_

![screenshot](/screenshot.png?raw=true)

## Installation

    git clone --recursive https://github.com/drewreeve/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    make install
    chsh -s /bin/zsh

`make install` will do the following:

* Install a few dependencies (curl, stow, ripgrep etc) via apt/pacman (I only use arch/debian/ubuntu currently)
* Stow (symlink) everything into **~/** (it won't replace existing files)
* Install [vim-plug](https://github.com/junegunn/vim-plug) and a [selection of plugins](https://github.com/drewreeve/dotfiles/tree/master/vim/.vim/rcplugins)
* Install [asdf](https://github.com/asdf-vm/asdf) for managing ruby/elixir/nodejs versions

This README isn't neccessarily always up to date so I recommend reading through the makefile to make
sure you're happy first (as you should whenever installing new things).

## Notes

#### Colorscheme

I use [gruvbox](https://github.com/morhetz/gruvbox) in vim and in my terminal.
You can find gruvbox colors for most terminals/apps in the [gruvbox-contrib](https://github.com/morhetz/gruvbox-contrib) repo.

#### Font
The font in the screenshot is [Pragmata Pro](https://www.fsd.it/shop/fonts/pragmatapro/)

Some other good fonts I like are:
* [Fira Mono](https://github.com/mozilla/Fira)
* [IBM Plex Mono](https://github.com/IBM/plex)


## Inspiration

* [thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles)
* [hashrockets dotfiles](https://github.com/hashrocket/dotmatrix)
* [ohmyzsh](https://github.com/robbyrussell/oh-my-zsh)
* [prezto](https://github.com/sorin-ionescu/prezto)
