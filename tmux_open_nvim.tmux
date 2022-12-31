#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-environment -g PATH "$PATH:$CURRENT_DIR/scripts/"
