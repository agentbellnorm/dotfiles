#!/bin/sh

INITIAL_WORKING_DIRECTORY=$(pwd)

git submodule update --init --recursive

for directory in "aerospace" "aliases" "nvim"; do
    echo "setting up $directory \n";

    cd "$directory"
    echo "now in $(pwd)"

    ./setup.sh

    cd "$INITIAL_WORKING_DIRECTORY"

    echo "done with $directory \n\n\n"
done
