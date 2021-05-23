#!/bin/sh
lock() {
  pkill -SIGUSR1 swayidle
}

case "$1" in
  lock)
    lock
    ;;
  logout)
    swaymsg exit
    ;;
  suspend)
    lock && systemctl suspend
    ;;
  hibernate)
    lock && systemctl hibernate
    ;;
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
    exit 2
esac

exit 0
