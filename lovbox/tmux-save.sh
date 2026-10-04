#!/usr/bin/env bash
set -euo pipefail

[[ "${1:-}" != --delay ]] || sleep 3
tmux has-session 2>/dev/null || exit 0
[[ "$(tmux show-option -gqv @lovbox-restoring)" != on ]] || exit 0

state_dir="$(tmux show-option -gqv @resurrect-dir)"
state_dir="${state_dir/#\~/$HOME}"
[[ -n "$state_dir" ]] || exit 0
mkdir -p "$state_dir"
chmod 700 "$state_dir"
exec 9>"$state_dir/save.lock"
flock -n 9 || exit 0

[[ "$(tmux show-option -gqv @lovbox-restoring)" != on ]] || exit 0
# Resurrect names snapshots to the second. Avoid colliding with a recent save.
now="$(date +%s)"
last_save="$(tmux show-option -gqv @lovbox-last-save)"
if [[ "$last_save" =~ ^[0-9]+$ ]] && (( now - last_save < 5 )); then
    exit 0
fi

"$HOME/.local/share/tmux/plugins/tmux-resurrect/scripts/save.sh" quiet
tmux set-option -g @lovbox-last-save "$now"
