#!/usr/bin/env bash

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        tmux set-environment -g PATH "${PATH:+"$PATH:"}$1"
    fi
}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pathadd "$CURRENT_DIR/scripts"
