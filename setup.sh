#!/usr/bin/env bash

git submodule update --init --recursive

# Create a symlink from `~/.local/share/nvim/init.vim` to `~/.config/nvim/init.vim`
ln -s $HOME/.local/share/nvim/init.vim $HOME/.config/nvim/init.vim

# Do the same for `~/.local/share/nvim/after` directory.
ln -s $HOME/.local/share/nvim/after $HOME/.config/nvim/after

# Create `tags/`, `undodir/` and `backupdir/` directories in `~/.local/share/nvim/`
mkdir ~/.local/share/nvim/{tags,undodir,backupdir}

# Create a symlink to rc files inside ./configs
ln -s ~/.local/share/nvim/config/linters/pylintrc $HOME/.config/
