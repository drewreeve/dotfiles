# Dotfiles

My collection of dotfiles for all the apps I use. I like to experiment with
things a lot so I tend to update them pretty frequently.

![screenshot](/screenshot.png?raw=true)

## Requirements

Set zsh as your login shell:

    chsh -s $(which zsh)

## Installation

    git clone --recursive https://github.com/drewreeve/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    make

The makefile by default will do the following:

* Install [Stow](https://www.gnu.org/software/stow/) via brew/apt/pacman
* Stow (symlink) everything into **~/** (it won't replace existing files)
* Install [vim-plug](https://github.com/junegunn/vim-plug) and a [selection of plugins](https://github.com/drewreeve/dotfiles/tree/master/vim/.vim/rcplugins)
* Install [asdf](https://github.com/asdf-vm/asdf) along with the ruby and nodejs plugins

## Notes

#### Colorscheme

I use [gruvbox](https://github.com/morhetz/gruvbox) in vim and in my terminal.
You can find gruvbox colors for most terminals/apps in the [gruvbox-contrib](https://github.com/morhetz/gruvbox-contrib) repo.

#### Font
The font in the screenshot is [Iosevka
Term](https://github.com/be5invis/Iosevka) which is what I'm using at the
moment.

Some other good fonts I like are:
* [Fira Mono](https://github.com/mozilla/Fira)
* [IBM Plex Mono](https://github.com/IBM/plex)


## Inspiration

* [thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles)
* [hashrockets dotfiles](https://github.com/hashrocket/dotmatrix)
* [ohmyzsh](https://github.com/robbyrussell/oh-my-zsh)
* [prezto](https://github.com/sorin-ionescu/prezto)
