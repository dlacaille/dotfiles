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

ICON_SEARCH_ROOTS=(
  "$HOME/.local/share/icons"
  "/usr/share/icons"
  "/usr/local/share/icons"
  "/var/lib/flatpak/exports/share/icons"
)

# Collect existing icon search roots
icon_args=()
for root in "${ICON_SEARCH_ROOTS[@]}"; do
  [ -d "$root" ] && icon_args+=("$root")
done

# Collect existing desktop dirs
desktop_args=()
for dir in "${DESKTOP_DIRS[@]}"; do
  [ -d "$dir" ] && desktop_args+=("$dir")
done

[ ${#icon_args[@]}    -eq 0 ] && printf '{}' && exit 0
[ ${#desktop_args[@]} -eq 0 ] && printf '{}' && exit 0

# Use awk for everything: build icon map, parse desktop files, emit JSON.
# Pass all icon files and desktop files via stdin with a separator marker.
{
  # Section 1: icon files (one per line, prefixed with "I:")
  find "${icon_args[@]}" \
    \( -path "*/apps/*.png" -o -path "*/apps/*.svg" \) \
    -not -path "*symbolic*" \
    -printf "I:%p\n" 2>/dev/null

  echo "---DESKTOP---"

  # Section 2: desktop files contents (emit "D:<file>" then key=value lines)
  find "${desktop_args[@]}" -maxdepth 1 -name "*.desktop" 2>/dev/null | \
  while IFS= read -r f; do
    echo "D:$(basename "$f")"
    grep -m1 "^Icon="            "$f" 2>/dev/null || true
    grep -m1 "^StartupWMClass="  "$f" 2>/dev/null || true
    echo "---"
  done
} | awk '
BEGIN {
  # Size preference: lower rank = better
  split("512x512 256x256 128x128 scalable 64x64 48x48", sizes, " ")
  for (i in sizes) size_rank[sizes[i]] = i + 0
  max_rank = length(sizes) + 1
  section = "icons"
  first = 1
  printf "{"
}

/^---DESKTOP---$/ { section = "desktop"; next }

section == "icons" {
  # Line format: I:/path/to/icon.png
  path = substr($0, 3)
  # Extract base name without extension
  n = split(path, parts, "/")
  fname = parts[n]
  # strip extension
  dot = index(fname, ".")
  name = (dot > 0) ? substr(fname, 1, dot - 1) : fname
  # Determine rank from path
  rank = max_rank
  for (sz in size_rank) {
    if (index(path, sz) > 0 && size_rank[sz] < rank) {
      rank = size_rank[sz]
    }
  }
  if (!(name in icon_best_rank) || rank < icon_best_rank[name]) {
    icon_best_rank[name] = rank
    icon_path[name] = path
  }
  next
}

section == "desktop" {
  if (/^D:/) {
    cur_stem = substr($0, 3)
    sub(/\.desktop$/, "", cur_stem)
    cur_icon = ""
    cur_wm = ""
    next
  }
  if (/^Icon=/)           { cur_icon = substr($0, 6);  next }
  if (/^StartupWMClass=/) { cur_wm   = substr($0, 17); next }
  if (/^---$/) {
    if (cur_icon == "") { cur_stem = ""; next }

    # Resolve icon path: try icon name, then stem lowercased
    gsub(/\r/, "", cur_icon)
    gsub(/\r/, "", cur_wm)

    ipath = ""
    if (substr(cur_icon, 1, 1) == "/") {
      ipath = cur_icon  # absolute path used as-is
    } else if (cur_icon in icon_path) {
      ipath = icon_path[cur_icon]
    } else {
      lower_stem = tolower(cur_stem)
      if (lower_stem in icon_path) ipath = icon_path[lower_stem]
    }

    if (ipath == "") { cur_stem = ""; next }

    # Emit keys: StartupWMClass, stem, short stem (strip reverse-dns)
    n_keys = 0
    if (cur_wm != "") keys[n_keys++] = tolower(cur_wm)
    keys[n_keys++] = tolower(cur_stem)
    # strip reverse-dns: org.foo.Bar -> bar
    short = cur_stem
    if (match(cur_stem, /^[A-Za-z]+\.[A-Za-z0-9]+\.(.+)/, m)) {
      short = tolower(m[1])
      if (short != tolower(cur_stem)) keys[n_keys++] = short
    }

    # JSON-escape helper (backslash and double-quote)
    for (ki = 0; ki < n_keys; ki++) {
      k = keys[ki]
      if (k == "" || k in seen) continue
      seen[k] = 1
      gsub(/\\/, "\\\\", k)
      gsub(/"/, "\\\"", k)
      v = ipath
      gsub(/\\/, "\\\\", v)
      gsub(/"/, "\\\"", v)
      if (!first) printf ","
      printf "\"" k "\":\"" v "\""
      first = 0
    }
    cur_stem = ""
    next
  }
}

END { printf "}" }
'
