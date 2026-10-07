# Dotfiles

`DOTFILES_DIR` and `MONOREPO_PATH` let the same terminal workflow use different
checkout locations. The aliases default to `~/kod/dotfiles` and `~/kod/lovable`
on a Mac. On a Lovbox, they detect the preloaded monorepo at `~/lovable`.
Export either variable before sourcing `aliases/aliases` to override the default.

`terminal/bin/new-worktree` and `terminal/tmuxinator/main.yml` also read
`MONOREPO_PATH`. Keep it exported in the shell that starts tmuxinator.
Tmuxinator starts `devenv deps` on a laptop; on a Lovbox, the dev stack is
already running, so its first pane shows the process list instead.
The editor pane opens `nvim .` in both the main session and new worktree sessions.
On a Lovbox, Neovim skips LSP plugins and language servers while keeping
Tree-sitter syntax highlighting; local Neovim keeps its LSP configuration.

On macOS, `terminal/setup.sh` links the Ghostty launcher into `~/.local/bin`.
Each new Ghostty terminal asks whether to use the local `main` session (Enter
or 1) or the `morgan-dev` Lovbox (2). The Lovbox choice uses `~/.ssh/lovbox.pub`
with the 1Password SSH agent, starts a paused box, and runs the remote setup
before attaching to `main`. It also forwards the SSH agent so the Codex session
can access the private repo. Ghostty's
quick terminal keeps its selection when hidden and shown again.

The launcher detects a sleep gap of at least 20 seconds and replaces this
window's SSH connection after wake, even if it still appears connected. Lovbox
SSH also sends a responsiveness check every 15 seconds and disconnects after
three unanswered checks. The launcher retries in the same window and reattaches
to an existing tmux session. Ctrl-C during reconnect returns to the launch menu;
detaching normally also returns to the menu. New connections skip the Lovbox
setup-readiness wait. `lovbox/setup-ssh.sh` installs the scoped SSH settings in
`lovbox/ssh-config` without changing GitHub or other hosts' SSH settings.
The checks detect an unresponsive SSH connection, not an application that still
responds slowly. A fresh SSH connection can be made without restarting tmux.

On the Lovbox, setup also keeps a `morgan-os` tmux session running with one
Codex pane in `~/kod/morgan-brain` (`MORGAN_OS_PATH` overrides that path).
Switch between `main` and `morgan-os` with `Ctrl-Space`, then `Tab` to open the
tmux session picker, or run `tmux switch-client -t morgan-os` from inside tmux.
The Morgan OS session persists after detaching and is recreated on the next
Lovbox login if it has ended.

Lovbox tmux uses `lovbox/tmux.conf`, which extends the shared shortcuts in
`terminal/tmux.conf`. Its layouts live in `lovbox/tmuxinator/`; the Mac's
layouts stay in `terminal/tmuxinator/`. Lovbox worktrees show the existing
process list instead of starting another dev stack.

Tmux Resurrect and Continuum save sessions, windows, panes, working directories,
and pane scrollback to `~/.local/state/lovbox/tmux/`. Saves run every minute while
attached, after layout changes, and on detach. `Ctrl-Space`, then `Ctrl-S` saves
immediately; `Ctrl-Space`, then `Ctrl-R` restores the latest snapshot manually.
The launcher restores the saved environment before creating missing `main` and
`morgan-os` sessions. This includes worktree sessions created after setup.

Recovery relaunches Neovim and opens `codex resume` in saved Codex panes so you
can select the previous conversation. It also restores process-list panes;
builds and dev servers return as shells. Snapshots do not preserve process
memory, running requests, or unsaved editor buffers. History saved by Codex
remains in the persistent home directory. There is no snapshot of tmux sessions
lost before this setup was installed.

The root `setup.sh` is for macOS and uses Homebrew and AeroSpace. Lovbox
includes tmux and fzf. From a Lovbox checkout at `~/kod/dotfiles`, run
`./lovbox/setup.sh` to install Zsh and tmuxinator, link the tmux config and
worktree helper, install Neovim and link its config, and configure SSH login
to enter Zsh. It also installs Ghostty's terminfo entry so remote tmux can use
`TERM=xterm-ghostty`. The login hook reruns
the setup if a new pod needs the system packages again. The home directory,
including your shell and tmux config, persists across pod replacements.

`zsh/oh-my-zsh.zsh` holds the shared Oh My Zsh theme and plugin choices.
`zsh/p10k.zsh` is Morgan's Powerlevel10k prompt configuration and is linked as
`~/.p10k.zsh` on both machines. The Mac and Lovbox source the shared settings
from their own `zshrc` files, so Mac-only tool initialization stays local.
`zsh/install.sh` installs Oh My Zsh, Powerlevel10k, and zsh-autosuggestions
when absent; the setup scripts leave existing checkouts alone.
