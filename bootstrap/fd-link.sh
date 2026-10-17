#!/bin/sh
# Debian and Ubuntu install fd as fdfind; link it as fd.

set -eu

if command -v fdfind >/dev/null && [ ! -e "$HOME/.local/bin/fd" ]; then
  mkdir -p "$HOME/.local/bin"
  ln -s "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi
