# Dotfiles

My collection of dotfiles for all the apps I use. I like to experiment with
things a lot so I tend to update them pretty frequently.

![screenshot](http://imgh.us/dotfiles.png)

## Features

* **Zsh**. I use zshell but without any frameworks like prezto or ohmyzsh
(although I've certainly borrowed snippets from both at some point). I also
have my prompt setup to display useful git information (current branch,
unstaged files etc).
* **vim/neovim**. My editor of choice. I used textmate for a long time before I
made the switch but now I wouldn't be without it. I'm currently favouring neovim 
as my aging iMac seems to handle running it a bit better. That and the async
linting is pretty nice.
* **git**. Obvious one :) I haven't had to use mercurial or svn in a long time
so this is the only vcs I customize.
* **rbenv/chruby**. I use ruby a lot so I have things set up such that rbenv or
chruby get set up automatically if they're detected in `$PATH`. _Currently if
both are installed rbenv is favoured._

## Requirements

Set zsh as your login shell:

    chsh -s $(which zsh)

## Installation

The install script overwrites any pre-existing dotfiles with symlinks as needed
so be sure to make copies first. That or rename them to `~/.filename.local` as
most of the files look for a `.local` variant for machine specific overrides.
As well as symlinking the files it also fires up vim and installs all of the
plugins in [vimrc.bundles](https://github.com/drewreeve/dotfiles/blob/master/vimrc.bundles)

    git clone git://github.com/drewreeve/dotfiles.git ~/.dotfiles
    ~/.dotfiles/install.sh

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
