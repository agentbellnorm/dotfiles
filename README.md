# Dotfiles

`DOTFILES_DIR` and `MONOREPO_PATH` let the same terminal workflow use different
checkout locations. The aliases default to `~/kod/dotfiles` and `~/kod/lovable`
on a Mac. On a Lovbox, they detect the preloaded monorepo at `~/lovable`.
Export either variable before sourcing `aliases/aliases` to override the default.

`terminal/bin/new-worktree` and `terminal/tmuxinator/main.yml` also read
`MONOREPO_PATH`. Keep it exported in the shell that starts tmuxinator.
Tmuxinator starts `devenv deps` on a laptop; on a Lovbox, the dev stack is
already running, so its first pane shows the process list instead.

The root `setup.sh` is for macOS and uses Homebrew and AeroSpace. On a Lovbox,
link the terminal config from a checkout of this repo and source the aliases
from the shell you use:

```sh
ln -s "$HOME/kod/dotfiles/terminal/tmux.conf" "$HOME/.tmux.conf"
printf '\nsource "$HOME/kod/dotfiles/aliases/aliases"\n' >> "$HOME/.zshrc"
```

Lovbox includes tmux and fzf. Install tmuxinator separately if you want the
`main.yml` layout or the `new-worktree` helper. It opens Bash over SSH. To use
Zsh interactively, install it inside the box
(`sudo apt-get update && sudo apt-get install -y zsh`) and run `exec zsh -l`.
Add `eval "$(direnv hook zsh)"` to `~/.zshrc` for the monorepo environment.
The home directory persists, while system package installs may need repeating
after a pod replacement.
