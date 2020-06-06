#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Tweak some key mappings
# Tab -> Super_L
# Caps lock acts as ctrl
# Both shift keys toggle caps lock
setxkbmap -print | sed -e '/xkb_symbols/s/"\(.*\)"/"\1+capslock(ctrl_modifier)+shift(both_capslock)+drew(tab_super)"/' | xkbcomp -I"$HOME/.xkb" - "$DISPLAY" 2>/dev/null

killall xcape -q

# Tapping capslock acts like Escape, holding with other key acts like ctrl
# Tapping tab acts like tab, pressing with other key acts like Super_L
xcape -t 1000 -e 'Caps_Lock=Escape;Super_L=Tab'

exec i3
