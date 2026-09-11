#!/bin/bash

export HOMEBREW_AUTO_UPDATE_SECS=86400

brew bundle install
brew bundle cleanup --force

if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"
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

zsh defaults
