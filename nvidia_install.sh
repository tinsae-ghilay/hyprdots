#!/bin/bash

echo "Installing nvidia drivers"

pacman -S --needed --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings nvidia-prime

setup(){

    echo "adding pacman hook"
    # create hooks folder first
    curl -fsSL https://raw.githubusercontent.com/tinsae-ghilay/hyprdots/refs/heads/master/nvidia.hook -o /etc/pacman.d/hooks/nvidia.hook

    echo "Adding nvidia modul parameters"
    echo 'options nvidia NVreg_DynamicPowerManagement=0x02' > /etc/modprobe.d/nvidia-pm.conf
    echo "adding udev rules"
    curl -fsSL https://raw.githubusercontent.com/tinsae-ghilay/hyprdots/refs/heads/master/80-nvidia-pm.rules -o /etc/udev/rules.d/80-nvidia-pm.rules

}

echo "Setting Kernel parameters"

if grep -q 'nvidia_drm.modeset=1' /boot/loader/entries/arch.conf; then

    echo "Kernel parameter already set. Skipping."

elif sed -i '/^options / s/$/ nvidia_drm.modeset=1/' /boot/loader/entries/arch.conf; then

    echo "Kernel parameters updated successfully."
else
    echo "Failed to add nvidia_drm kernel parameter."
fi

setup
