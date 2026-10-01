#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export DOTFILES_DIR="$dotfiles_dir"
export MONOREPO_PATH="${MONOREPO_PATH:-$HOME/lovable}"

if ! command -v zsh >/dev/null 2>&1 || ! command -v tmuxinator >/dev/null 2>&1 || ! command -v nvim >/dev/null 2>&1 || ! command -v tic >/dev/null 2>&1; then
    sudo apt-get update -qq
    sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh tmuxinator neovim ncurses-bin
fi

if ! infocmp -x xterm-ghostty >/dev/null 2>&1; then
    tic -x -o "$HOME/.terminfo" "$dotfiles_dir/terminal/terminfo/xterm-ghostty.ti"
fi

"$dotfiles_dir/zsh/install.sh"

mkdir -p "$HOME/.config/tmuxinator" "$HOME/.local/bin"
link_if_missing() {
    if [[ ! -e "$2" && ! -L "$2" ]]; then
        ln -s "$1" "$2"
    fi
}
link_if_missing "$dotfiles_dir/terminal/tmux.conf" "$HOME/.tmux.conf"
link_if_missing "$dotfiles_dir/terminal/tmuxinator/main.yml" "$HOME/.config/tmuxinator/main.yml"
link_if_missing "$dotfiles_dir/terminal/bin/new-worktree" "$HOME/.local/bin/new-worktree"
link_if_missing "$dotfiles_dir/nvim" "$HOME/.config/nvim"
link_if_missing "$dotfiles_dir/zsh/zshrc.lovbox" "$HOME/.zshrc"

if [[ ! -e "$HOME/.tmux.conf.local" ]]; then
    printf 'set -g default-shell %s\n' "$(command -v zsh)" > "$HOME/.tmux.conf.local"
fi

if ! grep -Fq '# dotfiles-lovbox login' "$HOME/.bash_profile" 2>/dev/null; then
    cat >> "$HOME/.bash_profile" <<'EOF'

# dotfiles-lovbox login
if [[ $- == *i* ]] && [[ -x "$HOME/kod/dotfiles/lovbox/setup.sh" ]]; then
    "$HOME/kod/dotfiles/lovbox/setup.sh" && exec zsh -l
fi
EOF
fi
