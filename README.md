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
Each new Ghostty terminal offers `main` locally (press Enter or 1) or on the
`morgan-dev` Lovbox (2), plus a Morgan OS session locally (3) or on the Lovbox
(4). The Morgan OS session starts one Codex pane in the `morgan-brain` repo
(`~/kod/morgan-os` on the Mac, `~/kod/morgan-brain` on the Lovbox). Set
`MORGAN_OS_PATH` to override the checkout location. The Lovbox choices use
`~/.ssh/lovbox.pub` with the 1Password SSH agent, start a paused box, and run
the remote setup before attaching to tmux. The Morgan OS choice also forwards
the SSH agent so Codex can access the private repo. Ghostty's
quick terminal keeps its selection when hidden and shown again.

To create or attach to Morgan OS from a shell, run `tmuxinator start morgan-os`.
Within tmux, use `tmux switch-client -t morgan-os` to switch to it. It stays
running after you detach, just like `main`; reconnecting attaches to the same
Codex pane.

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
