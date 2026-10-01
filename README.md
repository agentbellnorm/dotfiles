# Dotfiles

`DOTFILES_DIR` and `MONOREPO_PATH` let the same terminal workflow use different
checkout locations. The aliases default to `~/kod/dotfiles` and `~/kod/lovable`
on a Mac. On a Lovbox, they detect the preloaded monorepo at `~/lovable`.
Export either variable before sourcing `aliases/aliases` to override the default.

`terminal/bin/new-worktree` and `terminal/tmuxinator/main.yml` also read
`MONOREPO_PATH`. Keep it exported in the shell that starts tmuxinator.
Tmuxinator starts `devenv deps` on a laptop; on a Lovbox, the dev stack is
already running, so its first pane shows the process list instead.

On macOS, `terminal/setup.sh` links the Ghostty launcher into `~/.local/bin`.
Each new Ghostty terminal asks whether to attach to the local `main` tmux
session (press Enter or 1) or the `morgan-dev` Lovbox session (press 2). The
Lovbox choice uses `~/.ssh/lovbox.pub` with the 1Password SSH agent, starts a
paused box, and runs the remote setup before attaching to tmux. Ghostty's
quick terminal keeps its selection when hidden and shown again.

The root `setup.sh` is for macOS and uses Homebrew and AeroSpace. Lovbox
includes tmux and fzf. From a Lovbox checkout at `~/kod/dotfiles`, run
`./lovbox/setup.sh` to install Zsh and tmuxinator, link the tmux config and
worktree helper, install Neovim and link its config, and configure SSH login
to enter Zsh. It also installs Ghostty's terminfo entry so remote tmux can use
`TERM=xterm-ghostty`. The login hook reruns
the setup if a new pod needs the system packages again. The home directory,
including your shell and tmux config, persists across pod replacements.
