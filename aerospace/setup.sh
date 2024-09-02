#!/bin/sh

echo "linking config"


rm ~/.aerospace.toml
ln -s "$(pwd)/.aerospace.toml" ~/.aerospace.toml


if ! [ -x "$(command -v aerospace)" ]; then
  echo 'aerospace not installed, installing' >&2
  brew install --cask nikitabobko/tap/aerospace
else 
  echo '✅ aerospace installed'
fi

aerospace reload-config

