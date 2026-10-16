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
`mise/.config/mise/config.toml`. On a new machine, install git (on macOS,
`xcode-select --install`), then run:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/drewreeve/dotfiles/main/install.sh)"
```

`install.sh` installs mise, clones this repo to `~/.dotfiles`, and runs
`mise bootstrap` against the config until it links itself into place. Any
arguments are passed to `mise bootstrap`, so `./install.sh --dry-run` previews
the changes. Open a new shell once it has finished.

After that, `mise dot apply` relinks and `mise dot status` shows what's deployed.
