#!/bin/bash

player_status=$(playerctl -p spotify status 2>/dev/null)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
	artist=$(playerctl -p spotify metadata artist | sed 's/&/\&amp;/g')
	title=$(playerctl -p spotify metadata title | sed 's/&/\&amp;/g')

	if [ "$player_status" = "Playing" ]; then
		echo '{"text": "󱑽 '"$artist - $title"' ", "class": "playing", "alt": "Spotify"}'
	else
		echo '{"text": " '"$artist - $title"' ", "class": "paused", "alt": "Spotify (Paused)"}'
	fi
fi
