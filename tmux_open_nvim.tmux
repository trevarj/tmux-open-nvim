#!/usr/bin/env bash

pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		NEW_PATH="${PATH:+"$PATH:"}$1"
		tmux set-environment -g PATH "$NEW_PATH"
	fi
}

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$CURRENT_DIR/scripts"
pathadd "$SCRIPT_DIR"
