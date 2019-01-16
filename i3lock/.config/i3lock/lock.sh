#!/usr/bin/env bash
set -eu

[[ -z "$(pgrep i3lock)" ]] || exit

revert() {
  xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 5 5 5
i3lock -e -f -c 000000 -n
revert
