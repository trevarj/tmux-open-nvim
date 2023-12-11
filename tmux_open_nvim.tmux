#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$CURRENT_DIR/scripts"

source "$CURRENT_DIR/scripts/helpers.sh"

path_add() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		NEW_PATH="${PATH:+"$PATH:"}$1"
		tmux set-environment -g PATH "$NEW_PATH"
	fi
}

set_open_strategy() {
	local strategy=$(get_tmux_option "$open_strategy" "$open_strategy_default")
	tmux set-option -gq "$open_strategy" "$strategy"
}

main() {
	set_open_strategy
	path_add "$SCRIPT_DIR"
}
main
