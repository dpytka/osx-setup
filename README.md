# macOS Setup Automation

This repository contains an automated setup script for macOS that installs essential command-line tools, applications, and configures a productive development environment.

## Overview

The setup script automates the installation and configuration of:
- Homebrew packages and casks
- Oh My Zsh with useful plugins
- Command-line utilities and development tools
- Essential applications

## Quick Start

To set up your macOS environment with all the configured tools and applications:

```bash
git clone https://github.com/yourusername/.osx-setup.git
cd .osx-setup
chmod +x setup.sh
./setup.sh
```

## What Gets Installed

### Command-Line Tools
- **cask** - Homebrew Cask for installing macOS applications
- **curl** - Data transfer tool
- **gh** - GitHub CLI
- **git** - Version control system
- **htop** - Process viewer
- **jq** - JSON processor
- **nvm** - Node Version Manager
- **rbenv** - Ruby environment manager
- **tree** - Directory listing utility
- **uv** - Python package manager
- **wget** - File retrieval utility
- **zsh** - Z shell

### Applications
- **WhatsApp** - Messaging application
- **Google Chrome** - Web browser
- **Zed** - Code editor
- **iTerm2** - Terminal emulator

### Shell Configuration
- **Oh My Zsh** - Zsh configuration framework
- **zsh-autosuggestions** - Autosuggestions for zsh commands
- **zsh-syntax-highlighting** - Syntax highlighting for zsh
- **fast-syntax-highlighting** - Fast syntax highlighting
- **zsh-autocomplete** - Real-time type-ahead autocomplete

## File Structure

```
.
├── Brewfile          # Homebrew packages and applications to install
├── setup.sh          # Main setup script
├── defaults/         # Default configuration files (if any)
└── README.md         # This file
```

## How It Works

1. The [`setup.sh`](setup.sh:1) script first installs all packages defined in the [`Brewfile`](Brewfile:1)
2. It then removes any packages not listed in the Brewfile
3. Installs Oh My Zsh if not already present
4. Clones useful Zsh plugins for enhanced functionality
5. Applies default configurations (if any exist in the defaults directory)

## Customization

### Adding New Packages
To install additional Homebrew packages or applications, add them to the [`Brewfile`](Brewfile:1):

```ruby
# For command-line tools
brew "package-name"

# For GUI applications
cask "app-name"
```

### Adding New Zsh Plugins
To add additional Zsh plugins, modify the [`setup.sh`](setup.sh:10) script:

```bash
git clone https://github.com/user/plugin-repo.git $ZSH_CUSTOM/plugins/plugin-name
```

### Adding Default Configurations
Place any default configuration files in the [`defaults`](defaults) directory. These will be applied during setup.

## Requirements

- macOS
- Homebrew (will be installed if not present)
- Internet connection

## Notes

- This script is designed for a fresh macOS installation but can be run on existing systems
- Existing configurations may be overwritten
- Some installations may require user interaction or administrative privileges

## Contributing

Feel free to submit issues and enhancement requests!

## License

This repository is licensed under the MIT License.
