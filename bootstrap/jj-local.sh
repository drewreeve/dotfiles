#!/bin/sh
# Write machine-specific jj signing config to conf.d/local.toml. Skips an
# existing file so manual edits survive; delete it to regenerate.

set -eu

LOCAL="${XDG_CONFIG_HOME:-$HOME/.config}/jj/conf.d/local.toml"
[ -e "$LOCAL" ] && exit 0

if [ "$(uname)" = Darwin ]; then
  signer="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
elif grep -qi microsoft /proc/version 2>/dev/null; then
  # 1Password runs on the Windows side, so use its signer
  user="$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')"
  signer="/mnt/c/Users/$user/AppData/Local/1Password/app/8/op-ssh-sign-wsl"
elif [ -x /opt/1Password/op-ssh-sign ]; then
  signer="/opt/1Password/op-ssh-sign"
fi

# Only sign where 1Password's signer exists, so pushes still work elsewhere
if [ -n "${signer:-}" ] && [ -x "$signer" ]; then
  mkdir -p "$(dirname "$LOCAL")"
  cat >"$LOCAL" <<EOF
signing.backends.ssh.program = "$signer"
git.sign-on-push = true
EOF
fi
