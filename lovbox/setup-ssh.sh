#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
include="Include \"$dotfiles_dir/lovbox/ssh-config\""
config="$HOME/.ssh/config"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if ! grep -Fxq "$include" "$config" 2>/dev/null; then
    temp_config="$(mktemp "$HOME/.ssh/config.lovbox.XXXXXX")"
    trap 'rm -f "$temp_config"' EXIT
    { printf '%s\n\n' "$include"; [[ ! -f "$config" ]] || cat "$config"; } > "$temp_config"
    chmod 600 "$temp_config"
    # Preserve a user-managed symlink when writing the updated config.
    cat "$temp_config" > "$config"
    chmod 600 "$config"
fi
