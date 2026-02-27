#!/bin/bash

# Get the PID of the focused window
FOCUSED_PID=$(hyprctl activewindow -j | jq -r '.pid')

# Check if the focused window is Konsole
FOCUSED_CLASS=$(hyprctl activewindow -j | jq -r '.class')

if [[ "$FOCUSED_CLASS" == "org.kde.konsole" ]]; then
    # Find the child shell process of Konsole to get its CWD
    SHELL_PID=$(pgrep -P "$FOCUSED_PID" | head -1)

    # Walk down the process tree to find the actual shell
    while true; do
        CHILD=$(pgrep -P "$SHELL_PID" | head -1)
        [[ -z "$CHILD" ]] && break
        SHELL_PID=$CHILD
    done

    CWD=$(readlink -f /proc/$SHELL_PID/cwd 2>/dev/null)
fi

# Open Konsole in that directory, or default to $HOME
if [[ -n "$CWD" && -d "$CWD" ]]; then
    konsole --workdir "$CWD" &
else
    konsole &
fi
