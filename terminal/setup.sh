#!/bin/sh

# ── ghostty ─────────────────────────────────────────────
echo "linking ghostty config"
mkdir -p ~/.config/ghostty
rm -f ~/.config/ghostty/config
ln -s "$(pwd)/ghostty/config" ~/.config/ghostty/config

# ── tmux config ─────────────────────────────────────────
echo "linking tmux.conf"
rm -f ~/.tmux.conf
ln -s "$(pwd)/tmux.conf" ~/.tmux.conf

# ── tmux ────────────────────────────────────────────────
if ! [ -x "$(command -v tmux)" ]; then
  echo "tmux not installed, installing"
  brew install tmux
else
  echo '✅ tmux installed'
fi

# ── tmuxinator ──────────────────────────────────────────
if ! [ -x "$(command -v tmuxinator)" ]; then
  echo "tmuxinator not installed, installing"
  brew install tmuxinator
else
  echo '✅ tmuxinator installed'
fi

echo "linking tmuxinator config"
mkdir -p ~/.config/tmuxinator
rm -f ~/.config/tmuxinator/main.yml
ln -s "$(pwd)/tmuxinator/main.yml" ~/.config/tmuxinator/main.yml

# ── new-worktree script ────────────────────────────────
echo "linking new-worktree script"
mkdir -p ~/.local/bin
rm -f ~/.local/bin/new-worktree
ln -s "$(pwd)/bin/new-worktree" ~/.local/bin/new-worktree
