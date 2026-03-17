#!/bin/bash
TERM_PID=$(hyprctl activewindow -j | jq -r '.pid')
SHELL_PID=$(pgrep -P "$TERM_PID" | tail -1)
CWD=$(readlink /proc/$SHELL_PID/cwd)

if [[ -n "$CWD" && -d "$CWD" ]]; then
    ghostty --working-directory="$CWD" "$@" &
else
    ghostty "$@" &
fi
