## Setup

Follow the steps in this [github wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim) to install Neovim

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

Follow the installation steps on this [github page](https://github.com/powerline/fonts)
to install powerline fonts for vim-airline. Use `Hack` font.

After everything has been installed, open neovim then run `:CocConfig` and paste
the following contents:

```bash
{
  "coc.preferences.noselect": false,
  "suggest.enablePreselect": true,
  "suggest.noselect": false
}
```
