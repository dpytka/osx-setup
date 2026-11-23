#!/bin/bash

export HOMEBREW_AUTO_UPDATE_SECS=86400

# Run from the repository root so relative paths (Brewfiles, defaults) resolve
cd "$(dirname "$0")" || exit 1

# Optional profile: ./setup.sh <name> installs Brewfile.<name> on top of Brewfile.base
PROFILE="${1:-}"
if [ -n "$PROFILE" ] && [ ! -f "Brewfile.$PROFILE" ]; then
  echo "Error: Brewfile.$PROFILE not found. Existing profiles:" >&2
  ls -1 Brewfile.* | sed 's/^Brewfile\.//' >&2
  exit 1
fi

BREW_SOURCES=(Brewfile.base)
[ -n "$PROFILE" ] && BREW_SOURCES+=("Brewfile.$PROFILE")
COMBINED="$(mktemp -t Brewfile)"
cat "${BREW_SOURCES[@]}" > "$COMBINED"

brew bundle install --file="$COMBINED"

# Opt-in: uninstalls anything not listed in base + profile. Dangerous on machines
# with pre-existing packages, so it only runs when BREW_CLEANUP=1 is set.
if [ "${BREW_CLEANUP:-0}" = "1" ]; then
  brew bundle cleanup --force --file="$COMBINED"
fi
rm -f "$COMBINED"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"
  git clone https://github.com/zsh-users/zsh-history-substring-search.git "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use"
  git clone https://github.com/fdellwing/zsh-bat.git "$ZSH_CUSTOM/plugins/zsh-bat"
else
  echo "Updating Zsh plugins..."
  for plugin_dir in "$ZSH_CUSTOM/plugins"/*/; do
    [ -d "$plugin_dir/.git" ] || continue # skip non-git directories (e.g. example)
    echo "Updating $(basename "$plugin_dir")..."
    git -C "$plugin_dir" pull --ff-only # never create merge commits in plugin repos
  done
fi

NVM_LATEST="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name // empty')"
if [ -z "$NVM_LATEST" ]; then
  NVM_LATEST="v0.40.7" # fallback when the GitHub API is unreachable
fi

if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM ($NVM_LATEST)..."
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_LATEST/install.sh" | bash
else
  export NVM_DIR="$HOME/.nvm"
  . "$NVM_DIR/nvm.sh" --no-use
  NVM_CURRENT="v$(nvm --version)"

  if [ "$NVM_CURRENT" = "$NVM_LATEST" ]; then
    echo "NVM is up to date ($NVM_CURRENT)."
  else
    echo "Updating NVM from $NVM_CURRENT to $NVM_LATEST..."
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_LATEST/install.sh" | bash
  fi
fi

# macOS preferences are personal - skip with SKIP_DEFAULTS=1
if [ "${SKIP_DEFAULTS:-0}" = "1" ]; then
  echo "Skipping macOS defaults (SKIP_DEFAULTS=1)"
else
  zsh defaults
fi
