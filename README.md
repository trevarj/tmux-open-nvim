# tmux-open-nvim

A tmux plugin that helps opening files in a Neovim instance

## Demo

[![asciicast](https://asciinema.org/a/549092.png)](https://asciinema.org/a/549092)

## Installation

Using TPM, add this to your `.tmux.conf`

```shell
set -g @plugin 'trevarj/tmux-open-nvim'
```

Reload tmux config (`<prefix>-I`). Also you may want to start a fresh session to
reload `$PATH` into your panes.

## Usage

### CLI

The plugin will add a helper script called `ton` to your path while
inside a tmux session.

The target use case of this plugin is when you have a tmux window that already
has a pane running `nvim` and a pane with a terminal:

```shell
$ ton file.txt # optionally add :[line]:[col] to the end, i.e file.txt:40:5
# Opens file.txt in nvim pane
```

### tmux-fingers (or tmux-open)

An optimal workflow using [tmux-fingers](https://github.com/Morantron/tmux-fingers):

Add this to your `.tmux.conf`:

```shell
# Overrides matching file paths with :[line]:[col] at the end
set -g @fingers-pattern-0 "((^|^\.|[[:space:]]|[[:space:]]\.|[[:space:]]\.\.|^\.\.)[[:alnum:]~_-]*/[][[:alnum:]_.#$%&+=/@-]+)(:[[:digit:]]*:[[:digit:]]*)?"
# Launches helper script on Ctrl+[key] in fingers mode
set -g @fingers-ctrl-action "xargs -I {} tmux run-shell 'cd #{pane_current_path}; ton {} > ~/.tmux/plugins/tmux-open-nvim/onvim.log'"s
```

Now you can enter fingers mode and use `Ctrl+[key]` to launch a file in `nvim`

## Caveat

Upon launch of a fresh tmux session, the script will not be in the first pane
due to how an environment is load, I guess. I think the only way to resolve this
is by adding the `~/.tmux/plugins/tmux-open-nvim/scripts` directory to your path
permanently or with `tmux -e PATH=$PATH:~/.tmux/plugins/tmux-open-nvim/scripts`
