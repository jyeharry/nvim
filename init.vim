
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
    set undodir=~/.vim/undodir
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
:nnoremap <space> za
set nofoldenable

" Shift tab to complete word
:inoremap <S-Tab> <C-P>

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
set backupdir=~/.vim/backupdir//,.
set directory=~/.vim/backupdir//,.

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
colorscheme desert

set t_Co=256

" Put plugins here
call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

