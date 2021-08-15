# Start gnome-keyring-daemon if we're in sway
case "$DESKTOP_SESSION" in
  sway)
    eval "$(gnome-keyring-daemon --start)"
    export SSH_AUTH_SOCK
    ;;
esac

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
