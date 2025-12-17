# Agent Guidelines for .dotfiles Repository

## Overview
Cross-platform (macOS/Linux) dotfiles repository using dotbot for installation. Primary languages: Bash, Python, Lua (Neovim), VimScript.

## Build/Test/Lint Commands
- **Install**: `./install` (main dotbot installer)
- **Test all**: `./test/test` (runs dotbot test suite)
- **Test single**: `./test/test <test-file>` (e.g., `./test/test tests/test-link.bash`)
- **Debug test**: `./test/test --debug <test-file>`
- **No linting/build**: This is a config repo; linting is configured in editors (ALE, LSP)

## Code Style Guidelines

### Shell Scripts (Bash)
- **Shebang**: `#!/usr/bin/env bash` (preferred) or `#!/bin/bash`
- **Indent**: 4 spaces (dotbot) or 2 spaces (general scripts)
- **Error handling**: Use `set -e` sparingly; prefer explicit checks
- **Functions**: Use for organization; document complex logic
- **Arguments**: Support `--help`, `--dry-run` flags where applicable
- **Output**: Color-coded (RED/GREEN/YELLOW/NC variables for user feedback)
- **Comments**: Header block explaining purpose, usage, options; inline for complex sections

### Python (Dotbot plugins)
- **Formatter**: Black (line-length: 100)
- **Indent**: 4 spaces
- **Version**: Python 2.7.18 compatible (legacy); support 3.5+
- **Linting**: ruff, mypy

### Lua (Neovim config)
- **Formatter**: StyLua (120 column width, 2 spaces)
- **Structure**: Follow NvChad conventions

### General
- **Line endings**: LF (Unix)
- **Charset**: UTF-8
- **Trailing whitespace**: Trim
- **Final newline**: Required
- **YAML indent**: 2 spaces

## Naming Conventions
- **Scripts**: `lowercase_snake_case.sh` for utilities
- **Config files**: Match application expectations (e.g., `tmux.conf`, `vimrc`, `zshrc`)
- **Functions**: `lowercase_snake_case` in bash
- **Variables**: `UPPERCASE` for constants, `lowercase` for locals

## Error Handling
- Validate inputs before execution
- Provide clear error messages with context
- Exit with non-zero status on failures
- Use lock files for concurrent script protection (see `brew_health.sh`)

## Repository Patterns
- **Platform detection**: Use `uname -s` or dotbot-ifplatform plugin
- **Submodules**: Don't modify; they're external dependencies (dotbot, oh-my-zsh, tpm)
- **Config locations**: Place in `config/` directory or root (platform-specific: `.osx`, `.linux` suffix)
- **Testing**: Add tests to `test/tests/` for new dotbot functionality; use `test_expect_success` pattern

## Git Workflow
- **Default branch**: `main`
- **Commits**: Clear, descriptive messages explaining "why" not just "what"
- **Submodules**: Marked as `ignore=dirty`; update intentionally

## Notes
- No Cursor/Copilot rules found; these are the established conventions
- Focus on cross-platform compatibility (macOS/Linux)
- Preserve existing symlink structure managed by dotbot
