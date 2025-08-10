#!/bin/sh

echo 'linking nvim config'
rm -rf ~/.config/nvim
ln -s "$(pwd)" ~/.config/nvim


if ! [ -x "$(command -v rg)" ]; then
  echo "ripgrep not installed, installing"
  brew install ripgrep
else 
  echo '✅ ripgrep installed'
fi

if ! [ -x "$(command -v jq)" ]; then
  echo "jq not installed, installing"
  brew install jq
else 
  echo '✅ jq installed'
fi

if ! [ -x "$(command -v prettierd)" ]; then
  echo "prettierd not installed, installing"
  npm install -g @fsouza/prettierd

else 
  echo '✅ prettierd installed'
fi

if ! [ -x "$(command -v eslint_d)" ]; then
  echo "eslint_d not installed, installing"
  npm i -g eslint_d

else 
  echo '✅ eslint_d installed'
fi

