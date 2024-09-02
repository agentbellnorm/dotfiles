#!/bin/sh

COMMAND="source $(pwd)/aliases"

if grep -Fxq "$COMMAND" ~/.zshrc; then
  echo "aliases already sourced in rc, not doing anything"
  exit 0
else 
  echo "aliases not in rc, adding"
  echo "$COMMAND" >> ~/.zshrc
  exit 0
fi

