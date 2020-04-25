#!/usr/bin/env bash

DEVICE=$(cat /device_tmp)

# Setup localization
sed -i "s/#en_GB.UTF-8/en_GB.UTF-8/" /etc/locale.gen
locale-gen
localectl set-locale LANG=en_GB.UTF-8

# Time
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
timedatectl set-ntp true
hwclock --systohc --utc

echo '%wheel ALL=(ALL) ALL' | sudo EDITOR='tee' visudo -f /etc/sudoers.d/01-enable-wheel

echo "Enter password for root user"
passwd

while true; do
  echo "Creating new non-root user"
  read -r -p "Enter username: " name
  if [ -n "$name" ]; then
    useradd -m -G wheel -s /bin/zsh "$name"
    passwd "$name"
    break
  fi
done

dd bs=512 count=4 if=/dev/random of=/crypto_keyfile.bin iflag=fullblock
chmod 600 /crypto_keyfile.bin
chmod 600 /boot/initramfs-linux*
cryptsetup luksAddKey "${DEVICE}2" /crypto_keyfile.bin

sed -i 's/BINARIES=()/BINARIES=(\/usr\/bin\/btrfs)/' /etc/mkinitcpio.conf
sed -i 's/FILES=()/FILES=(\/crypto_keyfile.bin)/' /etc/mkinitcpio.conf
sed -i '/\(^HOOKS\)/s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf

mkinitcpio -p linux

pacman -S --noconfirm grub efibootmgr amd-ucode intel-ucode
sed -i 's/^#GRUB_ENABLE_CRYPTODISK=y/GRUB_ENABLE_CRYPTODISK=y/' /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX=""//' /etc/default/grub
echo GRUB_CMDLINE_LINUX=\"cryptdevice=UUID="$(blkid "${DEVICE}2" -s UUID -o value)":cryptroot\" >> /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

mkdir /etc/systemd/system/dhcpcd@.service.d
cat >> /etc/systemd/system/dhcpcd@.service.d/no-wait.conf <<EOL
[Service]
ExecStart=
ExecStart=/usr/bin/dhcpcd -b -q %I
EOL
systemctl enable dhcpcd

rm /device_tmp
