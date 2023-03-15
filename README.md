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

```bash
mkdir ~/.local/share/nvim/{tags,undodir,backupdir}
```

NodeJS needs to be installed for CoC to work.

Visit [this page](https://github.com/universal-ctags/ctags) for instructions
on how to install Universal Ctags.

Visit [this page](https://github.com/sharkdp/fd) for instructions
on how to install fd (for telescope.nvim).

Visit [this page](https://github.com/BurntSushi/ripgrep) for instructions
on how to install ripgrep (for ctrlsf and telescope.nvim).

Follow the installation steps on [this page](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
to get telescope-fzf-native.nvim working (relies on cmake and other tools).

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
