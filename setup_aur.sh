#!/bin/bash

su "$1" -c "
  cd ~
  git clone https://aur.archlinux.org/wlogout.git &&
  cd wlogout &&
  curl 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf4fdb18a9937358364b276e9e25d679af73c6d2f' -o key.asc &&
  gpg --import key.asc &&
  makepkg -s --noconfirm
"

pacman -U /home/$1/wlogout/*.pkg.tar.zst --noconfirm
rm -rf /home/$1/wlogout

echo "Done , cleaning up"
rm -- "$0"