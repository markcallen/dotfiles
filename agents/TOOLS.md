# Runtime and tool discovery

Read when selecting or installing a runtime, package manager, CLI, or dependency. These are preferences for new work, not host assumptions or reasons to replace a working project setup.

1. Inspect the repo's `packageManager`, lockfile, `.nvmrc`, `go.mod`/`toolchain`, Python configuration and lockfile, Terraform constraints, Flutter config, setup scripts, and CI pins. Use their compatible versions and commands. Preserve existing npm, Yarn, Bun, pnpm, pip, uv, Go, or other choices.
2. Detect OS and executable availability with `uname -s`, `command -v`, and `<tool> --version`/`--help`. Use full executable names in scripts and noninteractive jobs; shell aliases such as `k`, `dc`, and `tf` may not load. Do not assume fixed Homebrew, Flutter, Go, or user-home paths.
3. Prefer pnpm for a new Node project and uv for a new Python project when no project constraint says otherwise. Use the repo's pinned Go, Dart/Flutter, Node, Python, and Terraform toolchains. Avoid host-wide upgrades and unpinned one-shot downloads as routine setup.
4. For infrastructure, verify `aws sts get-caller-identity`, region, `kubectl config current-context`, and namespace before a remote action. Use the project's provider and lockfile; render/lint/plan before any authorized apply. Local Compose/Kind checks are separate from production.
5. For secrets, use project-approved stores and short-lived identities. Installed `env-secrets aws --help` on 2026-10-10 supports process injection with `env-secrets aws -s <name> -r <region> --no-shell -- <program>`. Do not use undocumented `set`/`export`, shell `eval`, or examples containing values. An ignored file may be required by a repo; restrict permissions and do not commit it.
6. For Ballast, inspect `.rulesrc.json` and `ballast --help` before `doctor`, `setup-dev`, or refresh. Managed regions belong to Ballast; preserve repo customizations and avoid force upgrades unless the task calls for them.

This dotfiles repo uses Dotbot. `./install` changes the real home and runs network/setup steps; validate individual mappings in a disposable home instead. Repo-specific commands live in the root `AGENTS.md`.
