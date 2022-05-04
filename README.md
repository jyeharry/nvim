## Setup

Clone then run:

```bash
git submodule update --init --recursive
```

Create a symlink from `~/.local/share/nvim/init.vim` to `~/.config/nvim/init.vim`

```bash
ln -s $HOME/.local/share/nvim/init.vim $HOME/.config/nvim/init.vim
```

Do the same for `~/.local/share/nvim/after` directory.

```bash
ln -s $HOME/.local/share/nvim/after $HOME/.config/nvim/after
```

Create `tags/`, `undodir/` and `backupdir/` directories in `~/.local/share/nvim/`
