# tmux-open-nvim

A tmux plugin that helps opening files in a Neovim pane

## Demo

<a href="https://asciinema.org/a/631558" target="_blank"><img src="https://asciinema.org/a/631558.svg" width="500"/></a>

[old demo](https://asciinema.org/a/549092)
## Installation

Using TPM, add this to your `.tmux.conf`

```shell
set -g @plugin 'trevarj/tmux-open-nvim'
```

Reload tmux config (`<prefix>-I`). Also you may want to start a fresh session to
reload `$PATH` into your environment.

### Create symlink to `ton` script (optional)
Due to the caveat below, you can create a symlink to the `ton` script so it can
be used no matter what.

```shell
# Use any path that is on your $PATH
$ sudo ln -s ~/.tmux/plugins/tmux-open-nvim/scripts/ton /usr/local/bin/ton
```
## Configuration

Available configuration options to put in your `.tmux.conf`

|Config |Description   | Example
|---    |---           |---
|`set -g @ton-open-strategy ":e"` | Command for opening a file | `:e` or `:tabnew`
|`set -g @ton-menu-style` | Set style of display-menu for picking a pane | See `man tmux` STYLES
|`set -g @ton-menu-selected-style` | Set style of display-menu selection for picking a pane | See `man tmux` STYLES
|`set -g @ton-prioritize-window true` | If true and nvim exists in current window, opens directly in that instance. If false, prompts for a selection | `true` or `false`

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

If you have more than one Neovim instance running in a tmux window, or
`@ton-prioritize-window` is `false` and you have nvims in other windows, you
will be prompted with a tmux display-menu that will allow you to select where to
open the file.

#### Caveat

Upon launch of a fresh tmux session, the script will not be in the first pane
due to how an environment is loaded, I guess. I think the only way to resolve this
is by adding the `~/.tmux/plugins/tmux-open-nvim/scripts` directory to your path
permanently or with `tmux -e PATH=$PATH:~/.tmux/plugins/tmux-open-nvim/scripts`

> When you create a session, it creates window 0 automatically, which fires off a shell.
> So, for that shell, setenv doesn't work and you have to send-keys.
> But when you create a new window, like with split-window, the new window gets the environment from the setenv.
> The example shows that both windows have the environment whether set explicitly via export or via setenv.

See:
  - [Info](https://stackoverflow.com/a/49395839/506517)
  - [More Info](https://stackoverflow.com/a/49395839/506517)
  - [No env var restoration with tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect/issues/312)

### tmux-fingers (or tmux-open)

An optimal workflow using [tmux-fingers](https://github.com/Morantron/tmux-fingers):

Add this to your `.tmux.conf`:

```shell
# Overrides matching file paths with :[line]:[col] at the end
set -g @fingers-pattern-0 "(([.\\w\\-~\\$@]+)(\\/?[\\w\\-@]+)+\\/?)\\.([\\w]+)(:\\d*:\\d*)?"
# Launches helper script on Ctrl+[key] in fingers mode
set -g @fingers-ctrl-action "xargs -I {} tmux run-shell 'cd #{pane_current_path}; ~/.tmux/plugins/tmux-open-nvim/scripts/ton {} > ~/.tmux/plugins/tmux-open-nvim/ton.log'"s
```

Now you can enter fingers mode and use `Ctrl+[key]` to launch a file in `nvim`

## Future Features

- [x] A fzf-like selector that can target exactly which neovim instance you want to open a file in ([commit](https://github.com/trevarj/tmux-open-nvim/commit/3e511319706d357c523889b6620eb87c9f8abe65))
- [ ] Fix "caveat" above (maybe?)

## NOTE
You may be interested in a similar workflow that I have created using [telescope-tmux.nvim](https://github.com/trevarj/telescope-tmux.nvim),
where you can open up a Telescope picker and it will present to you all the file paths that
can be found in every tmux pane. Then, you can select the from the list.

<img src="https://github.com/trevarj/tmux-open-nvim/assets/5448324/60a76a27-0eb7-4522-b08e-3f6889435a17" width="500"/>

[See here for details](https://github.com/trevarj/telescope-tmux.nvim/tree/develop?tab=readme-ov-file#pane-file-paths)

