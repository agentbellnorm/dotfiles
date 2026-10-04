#!/usr/bin/env bash
set -euo pipefail

"$HOME/kod/dotfiles/lovbox/setup.sh"

if [[ ! -d "$HOME/kod/morgan-brain/.git" ]]; then
    mkdir -p "$HOME/kod"
    git clone git@github.com:agentbellnorm/morgan-brain.git "$HOME/kod/morgan-brain"
fi

# Keep the agent path stable for a Codex process that survives SSH reconnects.
if [[ -n "${SSH_AUTH_SOCK:-}" && -S "$SSH_AUTH_SOCK" ]]; then
    mkdir -p -m 700 "$HOME/.ssh"
    ln -sfn "$SSH_AUTH_SOCK" "$HOME/.ssh/lovbox-forwarded-agent.sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/lovbox-forwarded-agent.sock"
fi

"$HOME/kod/dotfiles/lovbox/start-sessions.sh"
exec tmux attach-session -t '=main'
