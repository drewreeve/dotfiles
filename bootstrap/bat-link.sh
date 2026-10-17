#!/bin/sh
# Debian and Ubuntu install bat as batcat; link it as bat.

set -eu

if command -v batcat >/dev/null && [ ! -e "$HOME/.local/bin/bat" ]; then
  mkdir -p "$HOME/.local/bin"
  ln -s "$(command -v batcat)" "$HOME/.local/bin/bat"
fi
