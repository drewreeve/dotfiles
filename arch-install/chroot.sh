#!/usr/bin/env bash

DEVICE=$(cat /device_tmp)

# Setup localization
sed -i "s/#en_GB.UTF-8/en_GB.UTF-8/" /etc/locale.gen
locale-gen
echo 'LANG=en_GB.UTF-8' >> /etc/locale.conf

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

sed -i '/\(^HOOKS\)/s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf

mkinitcpio -p linux

pacman -S --noconfirm efibootmgr amd-ucode intel-ucode

bootctl --path=/boot install

echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options cryptdevice=UUID=$(blkid "${DEVICE}2" -s UUID -o value):luks:allow-discards root=/dev/mapper/luks rd.luks.options=discard rw" >> /boot/loader/entries/arch.conf

rm /boot/loader/loader.conf

echo "timeout=3" >> /boot/loader/loader.conf
echo "console-mode=keep" >> /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf

mkdir /etc/systemd/system/dhcpcd@.service.d
cat >> /etc/systemd/system/dhcpcd@.service.d/no-wait.conf <<EOL
[Service]
ExecStart=
ExecStart=/usr/bin/dhcpcd -b -q %I
EOL
systemctl enable dhcpcd

rm /device_tmp
rm /chroot.sh
