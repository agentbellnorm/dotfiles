#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
state_dir="${LOVBOX_TMUX_STATE_DIR:-$HOME/.local/state/lovbox/tmux}"
bootstrap=lovbox-restore

# A live server owns the current state; restore only after it has disappeared.
if ! tmux has-session 2>/dev/null && [[ -s "$state_dir/last" ]]; then
    printf 'Restoring saved Lovbox tmux sessions...\n'
    tmux new-session -d -s "$bootstrap" -c "$HOME"
    tmux set-option -g @lovbox-restoring on
    # Resurrect is normally called from a tmux binding and needs its socket.
    TMUX="$(tmux display-message -p -t "$bootstrap" '#{socket_path},#{pid},0')" \
        "$HOME/.local/share/tmux/plugins/tmux-resurrect/scripts/restore.sh" \
        >"$state_dir/restore.log" 2>&1
    tmux set-option -g @lovbox-restoring off
fi

created=false
for session in main morgan-os; do
    if ! tmux has-session -t "=$session" 2>/dev/null; then
        tmuxinator start -p "$dotfiles_dir/lovbox/tmuxinator/$session.yml" --no-attach
        created=true
    fi
done

if tmux has-session -t "=$bootstrap" 2>/dev/null; then
    tmux kill-session -t "=$bootstrap"
fi

# Give new panes time to enter their editor/Codex command before the first save.
if "$created"; then sleep 2; fi
"$dotfiles_dir/lovbox/tmux-save.sh"
