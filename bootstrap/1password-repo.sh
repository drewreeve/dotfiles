#!/bin/sh
# Add 1Password's repo on Ubuntu and Fedora. mise can't declare these: the
# apt repo URL contains the architecture, and mise only adds COPR repos for dnf.
# See https://www.1password.dev/cli/get-started/

set -eu

KEY="https://downloads.1password.com/linux/keys/1password.asc"

if command -v apt-get >/dev/null && [ ! -e /etc/apt/sources.list.d/1password.sources ]; then
  sudo curl -fsSL -o /usr/share/keyrings/1password.asc "$KEY"
  sudo tee /etc/apt/sources.list.d/1password.sources >/dev/null <<SOURCES
Types: deb
URIs: https://downloads.1password.com/linux/debian/$(dpkg --print-architecture)
Suites: stable
Components: main
Signed-By: /usr/share/keyrings/1password.asc
SOURCES
  # mise only refreshes the lists after changing sources it manages
  sudo apt-get update -qq
fi

if command -v dnf >/dev/null && [ ! -e /etc/yum.repos.d/1password.repo ]; then
  sudo rpm --import "$KEY"
  sudo install -m 644 "$(dirname "$0")/1password.repo" /etc/yum.repos.d/1password.repo
fi
