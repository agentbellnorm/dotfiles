#!/usr/bin/env bash
set -euo pipefail

session="${1:-main}"
case "$session" in
    main|morgan-os) ;;
    *) printf 'Unknown tmux session: %s\n' "$session" >&2; exit 2 ;;
esac

"$HOME/kod/dotfiles/lovbox/setup.sh"

if [[ "$session" == morgan-os && ! -d "$HOME/kod/morgan-brain/.git" ]]; then
    mkdir -p "$HOME/kod"
    git clone git@github.com:agentbellnorm/morgan-brain.git "$HOME/kod/morgan-brain"
fi

# Keep the agent path stable for a Codex process that survives SSH reconnects.
if [[ "$session" == morgan-os && -n "${SSH_AUTH_SOCK:-}" && -S "$SSH_AUTH_SOCK" ]]; then
    mkdir -p -m 700 "$HOME/.ssh"
    ln -sfn "$SSH_AUTH_SOCK" "$HOME/.ssh/lovbox-forwarded-agent.sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/lovbox-forwarded-agent.sock"
fi

export TMUX_TARGET_SESSION="$session"
exec zsh -lic 'if tmux has-session -t "$TMUX_TARGET_SESSION" 2>/dev/null; then exec tmux attach-session -t "$TMUX_TARGET_SESSION"; else exec tmuxinator start "$TMUX_TARGET_SESSION"; fi'
