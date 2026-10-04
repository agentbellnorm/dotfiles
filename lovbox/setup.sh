#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export DOTFILES_DIR="$dotfiles_dir"
export MONOREPO_PATH="${MONOREPO_PATH:-$HOME/lovable}"

if ! command -v zsh >/dev/null 2>&1 || ! command -v tmuxinator >/dev/null 2>&1 || ! command -v nvim >/dev/null 2>&1 || ! command -v tic >/dev/null 2>&1 || ! command -v flock >/dev/null 2>&1; then
    sudo apt-get update -qq
    sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh tmuxinator neovim ncurses-bin util-linux
fi

if ! infocmp -x xterm-ghostty >/dev/null 2>&1; then
    tic -x -o "$HOME/.terminfo" "$dotfiles_dir/terminal/terminfo/xterm-ghostty.ti"
fi

"$dotfiles_dir/zsh/install.sh"

install_tmux_plugin() {
    local name="$1" revision="$2"
    local plugin_dir="$HOME/.local/share/tmux/plugins/$name"
    if [[ ! -d "$plugin_dir/.git" ]]; then
        git clone --quiet "https://github.com/tmux-plugins/$name.git" "$plugin_dir"
    fi
    if [[ "$(git -C "$plugin_dir" rev-parse HEAD)" != "$revision" ]]; then
        git -C "$plugin_dir" cat-file -e "$revision^{commit}" 2>/dev/null || git -C "$plugin_dir" fetch --quiet origin "$revision"
        git -C "$plugin_dir" checkout --quiet "$revision"
    fi
}
install_tmux_plugin tmux-resurrect cff343cf9e81983d3da0c8562b01616f12e8d548
install_tmux_plugin tmux-continuum 0698e8f4b17d6454c71bf5212895ec055c578da0

mkdir -p "$HOME/.config/tmuxinator" "$HOME/.local/bin" "$HOME/.local/state/lovbox/tmux"
chmod 700 "$HOME/.local/state/lovbox/tmux"
link_managed() {
    # Migrate links created by this repo, while retaining personal overrides.
    if [[ -L "$2" && "$(readlink "$2")" == "$dotfiles_dir/"* ]]; then
        ln -sfn "$1" "$2"
    elif [[ ! -e "$2" && ! -L "$2" ]]; then
        ln -s "$1" "$2"
    fi
}
link_managed "$dotfiles_dir/lovbox/tmux.conf" "$HOME/.tmux.conf"
link_managed "$dotfiles_dir/lovbox/tmuxinator/main.yml" "$HOME/.config/tmuxinator/main.yml"
link_managed "$dotfiles_dir/lovbox/tmuxinator/morgan-os.yml" "$HOME/.config/tmuxinator/morgan-os.yml"
link_managed "$dotfiles_dir/terminal/bin/new-worktree" "$HOME/.local/bin/new-worktree"
link_managed "$dotfiles_dir/nvim" "$HOME/.config/nvim"
link_managed "$dotfiles_dir/zsh/zshrc.lovbox" "$HOME/.zshrc"

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
