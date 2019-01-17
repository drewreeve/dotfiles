#!/bin/sh

set -eu

[ -z "$(pgrep i3lock)" ] || exit

revert() {
  xset dpms 0 0 0
}
trap revert HUP INT TERM

# Take screenshot and blur screen
TEMP_FILE=$(mktemp --suffix '.png')
RESOLUTION=$(xdpyinfo | awk '/dimensions/{print $2}')

ffmpeg -loglevel quiet -y -s "${RESOLUTION}" -f x11grab -i "${DISPLAY}" -vframes 1 -vf 'gblur=sigma=8' "${TEMP_FILE}"

# Turn off screen after 5 seconds while locked
xset +dpms dpms 5 5 5

i3lock -e -f -n -i "${TEMP_FILE}"
revert
