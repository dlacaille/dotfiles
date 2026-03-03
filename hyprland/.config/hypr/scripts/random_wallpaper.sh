#!/bin/bash
# Ensure hyprpaper is running
if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
fi
# Choose a random wallpaper from the specified directory
wallpapers_dir="$HOME/Pictures/Wallpapers"
random_wall=$(ls "$wallpapers_dir"/* | shuf -n 1)
# Set the random wallpaper using hyprctl
for i in {1..10}; do
    hyprctl hyprpaper wallpaper ",$random_wall" && break
    # If setting the wallpaper fails, wait for a moment and try again
    echo "Failed to set wallpaper, retrying... ($i/10)"
    sleep 0.5
done
