# macOS Setup Automation

This repository contains an automated setup script for macOS that installs essential command-line tools, applications, and configures a productive development environment.

## Overview

The setup script automates the installation and configuration of:
- Homebrew packages and casks
- Oh My Zsh with useful plugins
- NVM (Node Version Manager)
- Command-line utilities and development tools
- Essential applications
- macOS system preferences (trackpad, Finder)

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
- **age** - File encryption tool
- **ansible** - Automation and configuration management
- **bat** - `cat` clone with syntax highlighting
- **cask** - Homebrew Cask for installing macOS applications
- **curl** - Data transfer tool
- **dbmate** - Database migration tool
- **ffmpeg** - Audio and video processing
- **gh** - GitHub CLI
- **git** - Version control system
- **helm** - Kubernetes package manager
- **htop** - Process viewer
- **imagemagick** - Image manipulation tools
- **iperf3** - Network performance testing
- **jq** - JSON processor
- **just** - Command runner
- **kubernetes-cli** - Kubernetes command-line tool (kubectl)
- **libpq** - PostgreSQL client libraries
- **mkcert** - Locally-trusted development certificates
- **neovim** - Vim-fork text editor
- **nmap** - Network discovery and security auditing
- **qrencode** - QR code generator
- **rbenv** - Ruby environment manager
- **sops** - Secrets management
- **tree** - Directory listing utility
- **uv** - Python package manager
- **wget** - File retrieval utility
- **zsh** - Z shell

### Applications
- **Android File Transfer** - Android device file transfer
- **Claude Code** - AI coding agent
- **Cyberduck** - File transfer client
- **DBeaver Community** - Database management tool
- **Google Chrome** - Web browser
- **iTerm2** - Terminal emulator
- **LocalSend** - Local file sharing
- **VLC** - Media player
- **WhatsApp** - Messaging application
- **Zed** - Code editor

### Node Version Manager
- **NVM** - Installed via the official install script (v0.40.3) if not already present

### Shell Configuration
- **Oh My Zsh** - Zsh configuration framework
- **zsh-autosuggestions** - Autosuggestions for zsh commands
- **zsh-syntax-highlighting** - Syntax highlighting for zsh
- **fast-syntax-highlighting** - Fast syntax highlighting
- **zsh-autocomplete** - Real-time type-ahead autocomplete
- **zsh-history-substring-search** - Search command history by substring
- **you-should-use** - Reminds you of existing aliases for commands you type
- **zsh-bat** - Aliases and helpers for `bat`

### macOS Defaults
The [`defaults`](defaults) file applies system preferences:
- Enable trackpad tap-to-click
- Enable three-finger drag
- Disable `.DS_Store` creation on network and USB drives
- Show the path bar in Finder
- Hide hidden files in Finder
- Keep folders on top (Finder and Desktop)

## File Structure

```
.
├── Brewfile          # Homebrew packages and applications to install
├── setup.sh          # Main setup script
├── defaults          # macOS system preferences script (run with zsh)
└── README.md         # This file
```

## How It Works

1. The [`setup.sh`](setup.sh:1) script first installs all packages defined in the [`Brewfile`](Brewfile:1)
2. It then removes any packages not listed in the Brewfile
3. Installs Oh My Zsh and Zsh plugins if not already present
4. Installs NVM if not already present
5. Applies macOS system preferences from the [`defaults`](defaults) file

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
To add additional Zsh plugins, modify the [`setup.sh`](setup.sh:8) script:

```bash
git clone https://github.com/user/plugin-repo.git $ZSH_CUSTOM/plugins/plugin-name
```

### Adding New macOS Preferences
Add additional `defaults write` commands to the [`defaults`](defaults) file. These will be applied during setup.

## Requirements

- macOS
- Homebrew (packages are installed via `brew bundle`)
- Internet connection

## Notes

- This script is designed for a fresh macOS installation but can be run on existing systems
- `brew bundle cleanup --force` uninstalls anything not listed in the Brewfile, so be careful on systems with pre-existing packages
- Oh My Zsh, its plugins, and NVM are only installed if not already present
- Some installations may require user interaction or administrative privileges

## Contributing

Feel free to submit issues and enhancement requests!

## License

This repository is licensed under the MIT License.
