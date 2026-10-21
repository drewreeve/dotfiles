#!/bin/sh
# Bootstrap a new machine: install mise, clone the dotfiles, run mise bootstrap.
# Extra arguments are passed to `mise bootstrap`, e.g. `./install.sh --dry-run`.

set -eu

export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
REPO="https://github.com/drewreeve/dotfiles.git"

if ! command -v git >/dev/null 2>&1; then
  echo "install.sh: git is required (on macOS, run xcode-select --install)" >&2
  exit 1
fi

export PATH="$HOME/.local/bin:$PATH"

if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi

if [ ! -d "$DOTFILES/.git" ]; then
  git clone "$REPO" "$DOTFILES"
fi

# The whole config dir, so miserc.toml and the per-OS config files load too
MISE_CONFIG_DIR="$DOTFILES/mise/.config/mise" mise bootstrap "$@"

echo "Done. Open a new shell to pick up the new config."
