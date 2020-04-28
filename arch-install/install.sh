#!/usr/bin/env bash

query_hostname() {
  read -r -p "Enter a hostname for this machine (default=archy): " _hostname
  _hostname="${_hostname:-archy}"
}

query_disk() {
  mapfile -t DEVICES_LIST < <(lsblk -d | awk '{print "/dev/" $1}' | grep 'sd\|hd\|vd\|nvme\|mmcblk')
    echo -e '\nSelect device to setup partitions:'
    select DEVICE in "${DEVICES_LIST[@]}"; do
      break
    done
}

create_partitions() {
  echo "Creating partitions"
  sgdisk -Z "$DEVICE" # Wipe everything and create new GPT
  sgdisk "$DEVICE" -n 1::+550Mib -t 1:ef00 # EFI
  sgdisk "$DEVICE" -n 2 # System
}

create_filesystems() {
  mkfs.fat -F32 -n EFI "${DEVICE}1"

  cryptsetup luksFormat "${DEVICE}2"
  cryptsetup open "${DEVICE}2" luks

  mkfs.btrfs -f -L system /dev/mapper/luks

  mount --options="defaults,compress=zstd" /dev/mapper/luks /mnt

  btrfs subvolume create "/mnt/${_hostname}"
  btrfs subvolume create "/mnt/${_hostname}/@root"
  mkdir "/mnt/${_hostname}/@root/live"
  btrfs subvolume create "/mnt/${_hostname}/@root/live/snapshot"
  btrfs subvolume create "/mnt/${_hostname}/@home"
  btrfs subvolume create "/mnt/${_hostname}/@pacman_cache"
  btrfs subvolume create "/mnt/${_hostname}/@log"

  umount -R /mnt
}

mount_filesystems() {
  local mount_options="defaults,compress=zstd,relatime"

  mount -o "${mount_options},subvol=${_hostname}/@root/live/snapshot" /dev/mapper/luks /mnt
  mkdir /mnt/home
  mount -o "${mount_options},subvol=${_hostname}/@home" /dev/mapper/luks /mnt/home
  mkdir -p /mnt/var/log
  mount -o "${mount_options},subvol=${_hostname}/@log" /dev/mapper/luks /mnt/var/log
  mkdir -p /mnt/var/cache/pacman/pkg
  mount -o "${mount_options},subvol=${_hostname}/@pacman_cache" /dev/mapper/luks /mnt/var/cache/pacman/pkg

  mkdir /mnt/boot
  mount -o defaults "${DEVICE}1" /mnt/boot
}

install_arch_base() {
  pacstrap /mnt base base-devel linux linux-firmware dhcpcd git zsh vim btrfs-progs

  genfstab -U /mnt >> /mnt/etc/fstab

  echo "$_hostname" >> /mnt/etc/hostname
  {
    echo "127.0.0.1    localhost"
    echo "::1          localhost"
    echo "127.0.0.1    ${_hostname}.localdomain ${_hostname}"
  } >> /mnt/etc/hosts

  cp "$(cd "$(dirname "$0")" && pwd)/chroot.sh" /mnt/
  echo "${DEVICE}" >> /mnt/device_tmp
  arch-chroot /mnt /chroot.sh
}

echo -e "This script will remove ALL data from your chosen device irrevocably!"
read -r -p "Are you sure you want to continue? (Y/n) " confirm
case ${confirm:0:1} in
  Y )
    query_hostname
    query_disk
    create_partitions
    create_filesystems
    mount_filesystems
    install_arch_base
    echo "All done!"
  ;;
  * )
    echo "nope"
    exit
  ;;
esac
