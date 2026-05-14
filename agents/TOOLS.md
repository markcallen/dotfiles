# TOOLS.md

Preferred tools and version managers configured in this environment. When installing runtimes, packages, or dependencies, use these tools unless a project explicitly requires otherwise.

## Package Managers

### Homebrew (`brew`)
The primary system package manager on both macOS and Linux.
- macOS: `/opt/homebrew/bin/brew`
- Linux: `/home/linuxbrew/.linuxbrew/bin/brew`
- Use for: system tools, CLIs, compilers, and runtime version managers

### pnpm
Preferred Node.js package manager for projects.
- Installed at `$PNPM_HOME` (`~/.local/share/pnpm`)
- Use `pnpm` over `npm` or `yarn` when starting new Node projects

### Bun
Available as a fast JS runtime and package manager.
- Installed at `~/.bun/bin/bun`
- Use for: scripting, tooling, or projects that explicitly target Bun

### uv
Preferred Python package and project manager (fast Rust-based replacement for pip/pip-tools/venv).
- Use `uv` for all new Python projects: `uv init`, `uv add`, `uv run`
- Prefer over `pip`, `pip-tools`, or manual venv setup

### Yarn
Available for Node projects that require it.
- Installed at `~/.yarn/bin`
- Prefer `pnpm` for new projects; use `yarn` only when the project already uses it

## Runtime Version Managers

### nvm
Node.js version manager.
- Installed at `~/.nvm`
- Default global packages (installed on each `nvm install`): `corepack`, `fixjson`, `strip-json-comments-cli`
- Use `nvm install` / `nvm use` to manage Node versions per project

### pyenv
Python version manager.
- Initialized in shell when present
- Use to install and switch Python versions: `pyenv install`, `pyenv local`

### asdf
Multi-runtime version manager (available when installed via Homebrew).
- Use for runtimes not covered by nvm or pyenv

### tfenv
Terraform version manager.
- Installed at `~/.tfenv/bin`
- Use `tfenv install` / `tfenv use` to manage Terraform versions

### jenv
Java version manager.
- Installed at `~/.jenv/bin`
- Use `jenv add` / `jenv local` to manage JDK versions

## Languages & Runtimes

### Go
- Installed via Homebrew or `/usr/local/go`
- `GOPATH=~/go`; binaries at `~/go/bin`

### Rust
- Managed via `cargo` / `rustup` at `~/.cargo`
- Source `~/.cargo/env` to activate

### Python
- Managed via `pyenv` + `uv`
- Use `uv` for dependency management; `pyenv` for version selection

### Node.js
- Managed via `nvm`
- Use `pnpm` or `bun` for package management

### Flutter / Dart
- SDK at `~/develop/flutter/bin`

## Infrastructure Tools

### Terraform
- Version managed via `tfenv`
- Shell alias: `tf=terraform`

### Pulumi
- Installed at `~/.pulumi/bin`

### kubectl
- Shell alias: `k=kubectl`

### Docker Compose
- Shell alias: `dc=docker compose`

## Shell & Terminal

### Shell: bash (with vi mode)
- `set -o vi` is active — vi keybindings in the shell
- Editor: `vim` (`EDITOR=vim`, `GIT_EDITOR=vim`)

### Oh My Zsh
- Theme: `robbyrussell`
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`

### Powerline
- Active in both macOS and Linux interactive shells

### tmux
- Config at `~/.tmux.conf`

## Secrets

Use `env-secrets` to manage secrets — see the Secrets Management section in [AGENTS.md](./AGENTS.md).
- Never use `.env` files
- Load with `eval $(env-secrets export)`
- Alias for codex with AWS: `codex-local`

## Dotfiles Management

Managed via [dotbot](https://github.com/anishathalye/dotbot) with `install.conf.yaml`.
- Run `./install` from `~/.dotfiles` to apply symlinks and setup
