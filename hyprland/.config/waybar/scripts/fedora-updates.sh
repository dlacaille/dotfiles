#!/usr/bin/env bash
# Waybar module: Fedora update checker
# Dependencies: dnf (or dnf5)
# Place this script somewhere like ~/.config/waybar/scripts/fedora-updates.sh
# and make it executable: chmod +x fedora-updates.sh

CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-fedora-updates"
CACHE_TTL=300  # 5 minutes in seconds

get_update_count() {
    # Try dnf5 first, fall back to dnf
    if command -v dnf5 &>/dev/null; then
        dnf5 check-update -q --refresh 2>/dev/null | grep -c "^\S" || echo 0
    elif command -v dnf &>/dev/null; then
        dnf check-update -q 2>/dev/null | grep -c "^\S" || echo 0
    else
        echo 0
    fi
}

use_cache() {
    [[ -f "$CACHE_FILE" ]] || return 1
    local now modified age
    now=$(date +%s)
    modified=$(stat -c %Y "$CACHE_FILE" 2>/dev/null) || return 1
    age=$(( now - modified ))
    (( age < CACHE_TTL ))
}

if use_cache; then
    COUNT=$(cat "$CACHE_FILE")
else
    COUNT=$(get_update_count)
    echo "$COUNT" > "$CACHE_FILE"
fi

# Clamp to 0 in case grep returns empty/error
COUNT=${COUNT:-0}
[[ "$COUNT" =~ ^[0-9]+$ ]] || COUNT=0

if (( COUNT == 0 )); then
    # System is up to date — output nothing (hides the module)
    echo '{"text": "", "tooltip": "System is up to date", "class": "updated", "percentage": 0}'
elif (( COUNT < 10 )); then
    CLASS="few"
    echo "{\"text\": \"󰁪 ${COUNT}\", \"tooltip\": \"${COUNT} update(s) available\", \"class\": \"${CLASS}\", \"percentage\": ${COUNT}}"
elif (( COUNT < 50 )); then
    CLASS="many"
    echo "{\"text\": \"󰁪 ${COUNT}\", \"tooltip\": \"${COUNT} update(s) available\", \"class\": \"${CLASS}\", \"percentage\": ${COUNT}}"
else
    CLASS="critical"
    echo "{\"text\": \"󰁪 ${COUNT}\", \"tooltip\": \"${COUNT} update(s) available — update soon!\", \"class\": \"${CLASS}\", \"percentage\": ${COUNT}}"
fi
