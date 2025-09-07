#!/bin/bash


echo "what do you want to install as GU Interface?"
echo "1, Gnome"
echo "2, Hyprland"
echo "3, Plasma"
read DE


install_hyprland(){

    # Install Hyprland and all other packages ---
    echo "Installing Hyprland and all specified packages..."

    # hyprecosystem
    pacman -S --needed --noconfirm hyprland hypridle hyprlock hyprpaper hyprshot hyprpolkitagent hyprsunset && echo "--- DONE ---"

    # xdg desktop portal
    pacman -S --needed --noconfirm xdg-desktop-portal-hyprland xdg-desktop-portal-gtk && echo "--- DONE ---"

    # qt wayland support + wlogout dependencies
    pacman -S --needed --noconfirm qt5-wayland qt6-wayland meson scdoc && echo "--- DONE ---"
    # X11 support
    pacman -S --needed --noconfirm xorg-xwayland && echo "--- DONE ---"
    # msic needed
pacman -S --needed --noconfirm swaync kitty wofi yazi waybar wl-clip-persist && echo "--- DONE ---"

    # I found ly to be straight forward and enough
    pacman -S --needed --noconfirm ly && echo "Ly Installed successfuly"
    systemctl enable ly.service

    # copying dot files
    echo "copying config files"
    git clone "$REPO" /home/$USERNAME_INPUT/.config && echo "---- DONE CLONING DOT FILES! ----" || { echo "looks like config will have to be cloned manualy !"; }
    # just incase, setting ownership of config files to user
    chown -cR "$USERNAME_INPUT" /home/"$USERNAME_INPUT"/.config

    # Installing wlogout

    echo "Installing wlogout from upstream source"
    git clone https://github.com/ArtsyMacaw/wlogout.git && cd wlogout
    meson build
    ninja -C build
    ninja -C build install
    echo "DONE"
}

case "$DE" in

  "1")
    echo "chose Gnome"
    pacman -S --needed --noconfirm gdm && systemctl enable gdm.service
    ;;

  "2")
    echo "chose Hyprland"
    install_hyprland

    ;;

  "3")
    echo "Chose Plasma desktop"
    pacman -S --needed --noconfirm plasma-desktop
    ;;

  *)
    echo "chose none, Arch will be headless"
    ;;
esac
