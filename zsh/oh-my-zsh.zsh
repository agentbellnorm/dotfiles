export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/kod/dotfiles}"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-autosuggestions)

source "$ZSH/oh-my-zsh.sh"
source "$DOTFILES_DIR/aliases/aliases"
