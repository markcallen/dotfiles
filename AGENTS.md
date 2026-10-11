# Agent guidance for this dotfiles repository

This file covers this repository. Mark's global defaults are in `agents/AGENTS.md`, installed as `~/.agents/AGENTS.md`; its on-demand files live alongside it. Codex receives a generated copy at `~/.codex/AGENTS.md`. Repo guidance refines those defaults but cannot override platform permissions or explicit user instructions. If the global file is absent, read the checked-in core directly for this repo.

## Repository and safe verification

- Dotbot installs cross-platform Bash, Zsh, Neovim/Lua, Vimscript, and other configuration from `install.conf.yaml`. Preserve the existing symlink layout and keep submodule pointers intentional.
- `./install` changes the operator's real home, initializes submodules, downloads content, and runs editor setup. Do not run it against the real home for validation. Use `scripts/check-agent-rules.py` for agent-rule mapping and a disposable-home Dotbot link test.
- Dotbot's own test runner is `dotbot/test/test`; there is no tracked root `test/` directory in this checkout. Run relevant submodule tests only when changing Dotbot behavior, without editing the submodule. Agent-rule changes use `python3 scripts/sync-agent-rules.py --check` and `python3 scripts/check-agent-rules.py`.
- Use `uname -s` for macOS/Linux paths. Verify both platforms for shared behavior where practical, or report the missing platform and impact.

## Style and scope

- Shell scripts: prefer `#!/usr/bin/env bash`, explicit input checks, clear nonzero failures, and 2-space indentation for repo utilities. Support `--help` and `--dry-run` when applicable. Avoid unbounded retries and host-wide changes.
- Python scripts in this repo should use the minimum version established by their own runtime/CI. The old Python 2.7/3.5 claim and formatter/linter list belonged to other code and do not define compatibility here. New rule-maintenance scripts target Python 3.8+ standard library.
- Lua follows the existing Neovim/NvChad conventions and StyLua where configured. Use LF, UTF-8, a final newline, and no trailing whitespace; YAML uses two-space indentation.
- Place app config under `config/` or at the root as existing application conventions require. Do not modify third-party submodules while changing dotfiles guidance.

## Requirements and Git

- `PRD.md` records durable intended behavior for this repo. Update it when installation or runtime behavior changes, including rule loading expectations. Routine documentation fixes do not need a new section. Keep issue acceptance criteria and the relevant spec aligned.
- Default branch is `main`. Work on a branch, preserve unrelated local changes, and describe why in commits. Do not merge or deploy without authorization.
