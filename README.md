## Setup

Clone then run:

```
git submodule update --init --recursive
```

Create a symlink from `~/.local/share/nvim/init.vim` to `~/.config/nvim/init.vim`

```
ln -s $HOME/.local/share/nvim/init.vim $HOME/.config/nvim/init.vim
```

Create `tags/`, `undodir/` and `backupdir/` directories in `~/.local/share/nvim/`
