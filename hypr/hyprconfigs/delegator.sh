#!/bin/bash

# Path to main config
MAIN_CONFIG="$HOME/.config/hypr/hyprland.conf"

# Monitor detection
CONNECTED=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Determine which config to use
if echo "$CONNECTED" | grep -q "DP-1"; then
    CONFIG_TO_SOURCE="~/.config/hypr/hyprconfigs/dp1.conf"
elif echo "$CONNECTED" | grep -q "HDMI-A-1"; then
    CONFIG_TO_SOURCE="~/.config/hypr/hyprconfigs/hdmi.conf"
else
    CONFIG_TO_SOURCE="~/.config/hypr/hyprconfigs/default.conf"
fi

# Replace source line in main config
# Use | as delimiter to avoid issues with slashes in paths
sed -i "s|^source = .*|source = $CONFIG_TO_SOURCE|" "$MAIN_CONFIG"

# Reload Hyprland config
hyprctl reload
