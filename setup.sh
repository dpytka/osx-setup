#!/bin/bash

brew bundle install

if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

zsh defaults
