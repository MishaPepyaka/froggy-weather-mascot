#!/usr/bin/env bash
# Install Froggy Weather Mascot for the current user.
set -euo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
bin_dir="$HOME/.local/bin"
asset_dir="$HOME/.local/share/lockscreen"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/lock-weather"

mkdir -p "$bin_dir" "$asset_dir" "$cache_dir"
install -m 755 "$project_dir/scripts/lock-weather-winnipeg" "$bin_dir/lock-weather-winnipeg"
install -m 755 "$project_dir/scripts/lock-weather-toggle-variant" "$bin_dir/lock-weather-toggle-variant"

for asset in "$project_dir"/assets/frog-*.png; do
  install -m 644 "$asset" "$asset_dir/${asset##*/}"
done

printf 'Installed scripts in %s and mascot artwork in %s.\n' "$bin_dir" "$asset_dir"
printf 'Next: paste config/hyprlock-mascot.conf into ~/.config/hypr/hyprlock.conf.\n'
