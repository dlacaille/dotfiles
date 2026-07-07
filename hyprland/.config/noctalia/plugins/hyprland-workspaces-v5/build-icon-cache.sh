#!/usr/bin/env bash
# Scans .desktop files and resolves app class -> icon path.
# Outputs a JSON object: { "class": "/path/to/icon.ext", ... }
# Called async from service.luau to avoid blocking the Luau VM.

DESKTOP_DIRS=(
  "$HOME/.local/share/applications"
  "/usr/share/applications"
  "/usr/local/share/applications"
  "/var/lib/flatpak/exports/share/applications"
)

ICON_DIRS=(
  "$HOME/.local/share/icons"
  "/usr/share/icons"
  "/usr/local/share/icons"
  "/var/lib/flatpak/exports/share/icons"
)

# Listed best-first; lower index = higher preference
PREFERRED_SIZES=( "512x512" "256x256" "128x128" "scalable" "64x64" "48x48" )

find_icon_file() {
  local icon_name="$1"
  local best="" best_rank=99

  for base in "${ICON_DIRS[@]}"; do
    [ -d "$base" ] || continue
    for i in "${!PREFERRED_SIZES[@]}"; do
      local sz="${PREFERRED_SIZES[$i]}"
      for ext in png svg; do
        # Structure: <base>/<theme>/<size>/apps/<name>.<ext>
        for candidate in "$base"/*/"$sz"/apps/"$icon_name.$ext"; do
          [ -f "$candidate" ] || continue
          [[ "$candidate" == *symbolic* ]] && continue
          if [ "$i" -lt "$best_rank" ]; then
            best="$candidate"
            best_rank="$i"
          fi
        done
      done
    done
  done

  printf '%s' "$best"
}

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

declare -A seen
first=1
printf '{'

for dir in "${DESKTOP_DIRS[@]}"; do
  [ -d "$dir" ] || continue
  while IFS= read -r -d '' f; do
    icon_name="$(grep -m1 '^Icon=' "$f" 2>/dev/null | cut -d= -f2- | tr -d '\r')" || true
    [ -z "$icon_name" ] && continue

    fname="$(basename "$f")"
    stem="${fname%.desktop}"
    wm_class="$(grep -m1 '^StartupWMClass=' "$f" 2>/dev/null | cut -d= -f2- | tr -d '\r')" || true

    # Resolve icon path once per desktop file
    icon_path=""
    if [[ "$icon_name" == /* ]]; then
      [ -f "$icon_name" ] && icon_path="$icon_name"
    else
      icon_path="$(find_icon_file "$icon_name")"
      if [ -z "$icon_path" ]; then
        icon_path="$(find_icon_file "${stem,,}")"
      fi
    fi
    [ -z "$icon_path" ] && continue

    # Candidate lookup keys (all lowercase)
    keys=()
    [ -n "$wm_class" ] && keys+=( "${wm_class,,}" )
    keys+=( "${stem,,}" )
    # Strip reverse-dns prefix: org.mozilla.firefox -> firefox
    short="$(echo "$stem" | sed -E 's/^[a-zA-Z]+\.[a-zA-Z0-9]+\.(.+)$/\1/' | tr '[:upper:]' '[:lower:]')"
    [ "$short" != "${stem,,}" ] && keys+=( "$short" )

    for key in "${keys[@]}"; do
      [ -z "$key" ] && continue
      [ -n "${seen[$key]+x}" ] && continue
      seen["$key"]=1
      k="$(json_escape "$key")"
      v="$(json_escape "$icon_path")"
      if [ "$first" -eq 1 ]; then
        printf '"%s":"%s"' "$k" "$v"
        first=0
      else
        printf ',"%s":"%s"' "$k" "$v"
      fi
    done
  done < <(find "$dir" -maxdepth 1 -name '*.desktop' -print0 2>/dev/null)
done

printf '}'
