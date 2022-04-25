
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
unlet! skip_defaults_vim 
" source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
    set undodir=/Users/jyeharry/.local/share/nvim/undodir
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set ignorecase
set smartcase

set foldmethod=indent
nnoremap <space> za
set nofoldenable

" Shift tab to complete word
inoremap <S-Tab> <C-P>

" Use Shift-k/j to move line up or down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Down> :m '>+1<CR>gv=gv

nnoremap gf <C-w>gf

" Duplicate line
nnoremap <C-d> Y \| p

" Set backup directories
set backupdir=~/.local/share/nvim/backupdir//,.
set directory=~/.local/share/nvim/backupdir//,.

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Change tab settings
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab

set scrolloff=999

set linebreak

set encoding=utf-8

set wildmenu
set wildmode=longest:full,full

set laststatus=2

set autoindent
set smartindent

set number
set numberwidth=4

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

syntax enable
syntax on

set splitbelow         " Always split below
cabbrev bterm bo term 

"nnoremap <silent><C-]> <C-w><C-]><C-w>T
nmap <silent><C-Space> <C-w><C-]><C-w>T
nmap <C-@> <C-Space>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

noremap <Leader>y "*y
noremap <Leader>Y "+y

set cursorline

set background=dark

set t_Co=256

" Put plugins here
call plug#begin()
  Plug 'preservim/NERDTree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'PhilRunninger/nerdtree-visual-selection'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'sainnhe/everforest'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'tmsvg/pear-tree'

  Plug 'tpope/vim-surround'

  Plug 'prettier/vim-prettier'
call plug#end()

" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'hard'
" For better performance
let g:everforest_better_performance = 1
colorscheme everforest

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_auto_focus = 0

let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#insert_pragma = 'false'
let g:prettier#config#prose_wrap = 'preserve'
let g:prettier#config#require_pragma = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'

vmap { S{
vmap } S}
vmap ( S(
vmap ) S)
vmap [ S[
vmap ] S]
vmap ' S'
vmap " S"
vmap ` S`

let g:pear_tree_repeatable_expand=0

let NERDTreeWinSize=21

nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-p> :NERDTreeToggleVCS<CR>
nnoremap <leader>c :NERDTreeCWD<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>

let NERDTreeShowHidden=1

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

