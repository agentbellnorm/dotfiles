#!/bin/sh

echo "linking config"

rm ~/.aerospace.toml
ln -s .aerospace.toml ~/.aerospace.toml


if ! [ -x "$(command -v aerospace)" ]; then
  echo '❌ aerospace not installed' >&2
  exit 1
else 
  echo '✅ aerospace installed'
fi


