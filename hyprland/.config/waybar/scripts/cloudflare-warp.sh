#!/usr/bin/env bash
ICON_CONNECTED="󱇱"
ICON_DISCONNECTED="󰅣"
ICON_CONNECTING="󰔪"
ICON_ERROR="󰼯"

if ! command -v warp-cli &>/dev/null; then
    echo '{"text":"'"$ICON_ERROR"' No WARP","tooltip":"warp-cli not found","class":"error","alt":"error"}'
    exit 1
fi

raw=$(warp-cli status 2>/dev/null)

if [ "${1:-}" = "toggle" ]; then
    if echo "$raw" | grep -q "Connected"; then
        warp-cli disconnect
    elif echo "$raw" | grep -q "Disconnected"; then
        warp-cli connect
    fi
    pkill -RTMIN+8 waybar
    exit 0
fi

if echo "$raw" | grep -q "Connected"; then
    printf '{"text":"%s","tooltip":"Connected","class":"connected","alt":"connected"}\n' "$ICON_CONNECTED"
elif echo "$raw" | grep -q "Connecting"; then
    printf '{"text":"%s","tooltip":"Connecting...","class":"connecting","alt":"connecting"}\n' "$ICON_CONNECTING"
elif echo "$raw" | grep -q "Disconnected"; then
    printf '{"text":"%s","tooltip":"Disconnected","class":"disconnected","alt":"disconnected"}\n' "$ICON_DISCONNECTED"
else
    printf '{"text":"%s","tooltip":"Error or not running","class":"error","alt":"error"}\n' "$ICON_ERROR"
fi
