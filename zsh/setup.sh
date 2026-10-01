#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
"$dotfiles_dir/zsh/install.sh"
if [[ ! -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    ln -s "$dotfiles_dir/zsh/zshrc.mac" "$HOME/.zshrc"
fi
