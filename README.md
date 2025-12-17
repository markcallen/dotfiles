# dotfiles

Cross-platform (macOS/Linux) development environment configuration.

## Install

curl https://raw.githubusercontent.com/markcallen/dotfiles/master/terminal-setup.sh | bash -s

## Components

### Shell
- **bash**: Profile and RC files with platform-specific variants (.osx/.linux)
- **zsh**: Configuration with oh-my-zsh framework for plugins and themes
- **oh-my-zsh**: Plugin manager with git, docker, kubectl, and productivity plugins

### Editors
- **vim**: Configured with vim-plug, ALE linter, coc.nvim LSP, NERDTree, airline
- **neovim**: Modern Lua-based config with Mason LSP installer, syntax highlighting
- **EditorConfig**: Consistent coding styles across editors

### Terminal Multiplexer
- **tmux**: Split panes, session management, powerline theme, TPM plugin manager
- **gitmux**: Git status in tmux status bar
- **terminfo**: Custom terminal definitions (tmux-256color)

### Version Control
- **git**: Aliases, diff tools, merge strategies, platform-specific configs
- **git-template**: Hooks and templates for new repositories

### Development Tools
- **nvm**: Node.js version manager with default packages list
- **conda**: Python environment manager configuration
- **terraform**: Plugin cache directory, custom RC settings
- **yarn**: Package manager configuration

### Utilities
- **asciinema**: Terminal session recorder configuration
- **yamllint**: YAML file linting rules
- **powerline**: Status bar theming for shells and tmux

### Installation
- **dotbot**: Declarative dotfile installer with platform detection (dotbot-ifplatform)
- **Scripts**: Automated cleanup (terraform, yarn, nvm), brew health checks 
