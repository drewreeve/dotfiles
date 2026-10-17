#!/bin/sh
# Add GitHub's gh repo on Fedora. On Ubuntu, mise declares the apt source.
# See https://github.com/cli/cli/blob/trunk/docs/install_linux.md

set -eu

if command -v dnf >/dev/null && [ ! -e /etc/yum.repos.d/gh-cli.repo ]; then
  sudo curl -fsSL -o /etc/yum.repos.d/gh-cli.repo https://cli.github.com/packages/rpm/gh-cli.repo
fi
