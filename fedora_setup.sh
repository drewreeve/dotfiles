#!/usr/bin/env bash

set -euo pipefail

install_dependencies() {
  sudo dnf install \
    alacritty \
    bat \
    ripgrep \
    stow \
    mako \
    gammastep \
    grim \
    vim \
    sway \
    swaylock \
    swayidle \
    waybar \
    wofi \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting
}

# https://wiki.archlinux.org/title/GNOME/Keyring#Start_SSH_and_Secrets_components_of_keyring_daemon
setup_keyring_autostart() {
  mkdir -p ~/.config/autostart

  if ! [[ -f ~/.config/autostart/gnome-keyring-secrets.desktop ]]; then
    cp -v /etc/xdg/autostart/gnome-keyring-secrets.desktop ~/.config/autostart
    sed -i /OnlyShowIn/d ~/.config/autostart/gnome-keyring-secrets.desktop
  fi

  if ! [[ -f ~/.config/autostart/gnome-keyring-ssh.desktop ]]; then
    cp -v /etc/xdg/autostart/gnome-keyring-ssh.desktop ~/.config/autostart
    sed -i /OnlyShowIn/d ~/.config/autostart/gnome-keyring-ssh.desktop
  fi
}

install_dependencies
setup_keyring_autostart
