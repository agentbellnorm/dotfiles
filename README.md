# Dotfiles

`DOTFILES_DIR` and `MONOREPO_PATH` let the same terminal workflow use different
checkout locations. The aliases default to `~/kod/dotfiles` and `~/kod/lovable`
on a Mac. On a Lovbox, they detect the preloaded monorepo at `~/lovable`.
Export either variable before sourcing `aliases/aliases` to override the default.

`terminal/bin/new-worktree` and `terminal/tmuxinator/main.yml` also read
`MONOREPO_PATH`. Keep it exported in the shell that starts tmuxinator.
Tmuxinator starts `devenv deps` on a laptop; on a Lovbox, the dev stack is
already running, so its first pane shows the process list instead.

The root `setup.sh` is for macOS and uses Homebrew and AeroSpace. Lovbox
includes tmux and fzf. From a Lovbox checkout at `~/kod/dotfiles`, run
`./lovbox/setup.sh` to install Zsh and tmuxinator, link the tmux config and
worktree helper, and configure SSH login to enter Zsh. The login hook reruns
the setup if a new pod needs the system packages again. The home directory,
including your shell and tmux config, persists across pod replacements.
