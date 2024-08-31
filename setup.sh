#!/bin/sh

echo 'linking nvim config'
rm -rf ~/.config/nvim
ln -s "$(pwd)" ~/.config/nvim


if ! [ -x "$(command -v rg)" ]; then
  "ripgrep not installed, installing"
  brew install ripgrep
else 
  echo '✅ ripgrep installed'
fi

if ! [ -x "$(command -v jq)" ]; then
  "jq not installed, installing"
  brew install jq
else 
  echo '✅ jq installed'
fi

if ! [ -x "$(command -v prettierd)" ]; then
  "prettierd not installed, installing"
  npm install -g @fsouza/prettierd

else 
  echo '✅ prettierd installed'
fi
