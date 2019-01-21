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

# Makes caps lock an additional ctrl key
setxkbmap -option 'caps:ctrl_modifier'

# Map tab to Hyper_L and any keycode to tab so that xcape still works
xmodmap -e 'keycode 23 = Hyper_L'
xmodmap -e 'keycode any = Tab'

# Tapping caps lock key acts like Escape key, holding acts like ctrl
# Tapping tab acts like tab, holding acts like Hyper_L (mod4)
xcape -t 1000 -e 'Caps_Lock=Escape;Hyper_L=Tab'

exec i3
