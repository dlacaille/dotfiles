#!/usr/bin/env bash

# Get the class of the currently active window
active_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ "$active_class" == "teams-for-linux" ]]; then
    # Send Ctrl+Shift+M to the active window
    ydotool key 29:1 42:1 50:1 134:1 134:0 50:0 42:0 29:0
    # Or with xdotool if on XWayland:
    # xdotool key ctrl+shift+m
else
    # Pass through the original mouse button 4 press
    ydotool click 0x04
fi
