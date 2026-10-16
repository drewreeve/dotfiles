# Dotfiles

My collection of dotfiles for all the apps I use.

These dotfiles work well **for me**. While you can feel free to copy anything
you wish, dotfiles are very personal and so where possible you should start 
from scratch yourself and include things which provide value for you.

## Requires:

* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [fd](https://github.com/sharkdp/fd)
* [mise](https://mise.jdx.dev)

## Install

Each top-level directory is a mise dotfile group, declared in
`mise/.config/mise/config.toml`. On a new machine, point mise at that config
until it links itself into place:

```sh
git clone <this repo> ~/.dotfiles
MISE_GLOBAL_CONFIG_FILE=~/.dotfiles/mise/.config/mise/config.toml mise bootstrap
```

After that, `mise dot apply` relinks and `mise dot status` shows what's deployed.
