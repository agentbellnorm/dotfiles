#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

clone_if_missing() {
    local url="$1" target="$2" expected="$3"
    if [[ ! -e "$target" && ! -L "$target" ]]; then
        mkdir -p "$(dirname -- "$target")"
        git clone --depth 1 "$url" "$target"
    fi
    if [[ ! -f "$target/$expected" ]]; then
        printf 'Incomplete Zsh installation: %s\n' "$target" >&2
        return 1
    fi
}

clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git \
    "$HOME/.oh-my-zsh" oh-my-zsh.sh
clone_if_missing https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" powerlevel10k.zsh-theme
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" zsh-autosuggestions.plugin.zsh

if [[ ! -e "$HOME/.p10k.zsh" && ! -L "$HOME/.p10k.zsh" ]]; then
    ln -s "$dotfiles_dir/zsh/p10k.zsh" "$HOME/.p10k.zsh"
fi
