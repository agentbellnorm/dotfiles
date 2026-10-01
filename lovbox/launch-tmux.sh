#!/usr/bin/env bash
set -euo pipefail

"$HOME/kod/dotfiles/lovbox/setup.sh"
exec zsh -lic 'if tmux has-session -t main 2>/dev/null; then exec tmux attach-session -t main; else exec tmuxinator start main; fi'
