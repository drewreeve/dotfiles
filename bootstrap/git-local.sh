#!/bin/sh
# Write machine-specific git signing config to ~/.gitconfig.local. Skips an
# existing file so manual edits survive; delete it to regenerate.

set -eu

LOCAL="$HOME/.gitconfig.local"
[ -e "$LOCAL" ] && exit 0

if [ "$(uname)" = Darwin ]; then
  signer="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
elif grep -qi microsoft /proc/version 2>/dev/null; then
  # 1Password runs on the Windows side, so use its ssh and signer
  user="$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')"
  signer="/mnt/c/Users/$user/AppData/Local/1Password/app/8/op-ssh-sign-wsl"
  git config --file "$LOCAL" core.sshCommand ssh.exe
elif [ -x /opt/1Password/op-ssh-sign ]; then
  signer="/opt/1Password/op-ssh-sign"
fi

# Only sign where 1Password's signer exists, so commits still work elsewhere
if [ -n "${signer:-}" ] && [ -x "$signer" ]; then
  git config --file "$LOCAL" gpg.ssh.program "$signer"
  git config --file "$LOCAL" commit.gpgsign true
fi
