#!/usr/bin/env bash

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set_open_strategy() {
  local strategy=$(get_tmux_option "$open_strategy" "$open_strategy_default")
  tmux set-option -gq "$open_strategy" "$strategy"
}

set_menu_style() {
  local style=$(get_tmux_option "$menu_style")
  tmux set-option -gq "$open_strategy" "$style"
}

set_menu_selected_style() {
  local style=$(get_tmux_option "$menu_selected_style")
  tmux set-option -gq "$menu_selected_style" "$style"
}

set_prioritize_window() {
  local opt=$(get_tmux_option "$prioritize_window" "$prioritize_window_default")
  tmux set-option -gq "$prioritize_window" "$opt"
}

main() {
  set_open_strategy
  set_menu_style
  set_menu_selected_style
  set_prioritize_window
}
main
