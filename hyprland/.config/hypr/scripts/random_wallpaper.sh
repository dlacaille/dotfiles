#!/bin/bash
wallpapers_dir="$HOME/Pictures/Wallpapers"
random_wall=$(ls "$wallpapers_dir"/* | shuf -n 1)
hyprctl hyprpaper wallpaper ",$random_wall"
