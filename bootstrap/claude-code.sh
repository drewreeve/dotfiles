#!/bin/sh
# Install Claude Code on Linux with Anthropic's native installer. On macOS,
# mise installs the Homebrew cask, which is macOS only.
# See https://code.claude.com/docs/en/setup

set -eu

if [ "$(uname -s)" = Linux ] && ! command -v claude >/dev/null && [ ! -e "$HOME/.local/bin/claude" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
