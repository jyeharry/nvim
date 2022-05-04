
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
    set undodir=~/.local/share/nvim/undodir
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

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set foldmethod=indent
nnoremap <space> za
set nofoldenable
set foldlevel=999

" Shift tab to complete word
inoremap <S-Tab> <C-P>

" Use Shift-k/j to move line up or down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Down> :m '>+1<CR>gv=gv

" Duplicate line
" nnoremap <C-d> Y \| p

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

set updatetime=100

set notildeop

set path=.,**

" Ignore certain files and directories when searching
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
set wildignore+=*/node_modules/**/*,*/dist/**/*
set wildignorecase

" Cycle buffers
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap gb :ls<CR>:b<Space>

" Search files project wide
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" Search files from current directory
nnoremap <leader>F :find <C-R>=expand('%:p:h').'*/**/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:p:h').'*/**/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:p:h').'*/**/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:p:h').'*/**/*'<CR>

" Search buffers
set wildcharm=<C-z>
nnoremap <leader>b :buffer <C-z>
nnoremap <leader>B :sbuffer <C-z>

" Search tags
nnoremap <leader>j :tjump /

" Put plugins here
call plug#begin()
  Plug 'preservim/NERDTree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'PhilRunninger/nerdtree-visual-selection'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'sainnhe/everforest'

  Plug 'mhartington/oceanic-next'

  Plug 'tpope/vim-fugitive'

  Plug 'airblade/vim-gitgutter'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'tmsvg/pear-tree'

  Plug 'tpope/vim-surround'

  Plug 'prettier/vim-prettier'

  Plug 'vim-airline/vim-airline'

  Plug 'vim-airline/vim-airline-themes'

  Plug 'prettier/vim-prettier'

  Plug 'ludovicchabant/vim-gutentags'

  Plug 'dyng/ctrlsf.vim'

call plug#end()

set signcolumn=yes

" Available values: 'hard', 'medium'(default), 'soft'
"let g:everforest_background = 'hard'
"" For better performance
"let g:everforest_better_performance = 1
"colorscheme everforest

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable
colo OceanicNext
highlight CocHighlightText ctermbg=Grey guibg=Grey ctermfg=Black guifg=Black

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat_config_present = 1

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

" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Open NERDTree and do NERDTreeFind if NERDTree is not open, close otherwise
function! ToggleNERDTree()
  if IsNERDTreeOpen()
    NERDTreeClose
  else
    NERDTreeFind
  endif
endfunction

nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-p> :call ToggleNERDTree()<CR>
nnoremap <leader>c :NERDTreeCWD<CR>
nnoremap <leader>r :NERDTreeVCS<CR>

let NERDTreeShowHidden=1

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:airline_theme='deus'

let g:airline#extensions#tabline#enabled = 1

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['branch'])
"    let g:airline_section_c = airline#section#create(['%t'])
    let g:airline_section_c = airline#section#create(['%{expand("%:~:.")}'])
    let g:airline_section_x = airline#section#create(['filetype'])
    let g:airline_section_y = airline#section#create(['ffenc',' ','%{gutentags#statusline()}'])
    let g:airline_section_z = airline#section#create(['%l','/','%L',':','%c'])
endfunction
autocmd VimEnter * call AirlineInit()

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#bufferline#enabled = 0

" Coc stuff
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-go', 'coc-css', 'coc-html', 'coc-sh', 'coc-markdownlint', 'coc-yaml']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <leader>rf <Plug>(coc-refactor)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" End Coc stuff

let g:gutentags_cache_dir = '~/.local/share/nvim/tags/'

" Ctrlsf stuff

" Use the ack tool as the backend
let g:ctrlsf_backend = 'ack'
" Auto close the results panel when opening a file
let g:ctrlsf_auto_close = { "normal":0, "compact":0 }
" Immediately switch focus to the search window
let g:ctrlsf_auto_focus = { "at":"start" }
" Don't open the preview window automatically
let g:ctrlsf_auto_preview = 0
" Use the smart case sensitivity search scheme
let g:ctrlsf_case_sensitive = 'smart'
" Normal mode, not compact mode
let g:ctrlsf_default_view = 'normal'
" Use absolute search by default
let g:ctrlsf_regex_pattern = 0
" Position of the search window
let g:ctrlsf_position = 'right'
" Width or height of search window
"let g:ctrlsf_winsize = '46'
" Search from the current working directory
let g:ctrlsf_default_root = 'project'
" Directories to ignore during search
let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules', 'dist', '.git']

" (Ctrl+F) Open search prompt (Normal Mode)
nmap <C-F> <Plug>CtrlSFPrompt 
" (Ctrl-F + F) Open search prompt with selection (Visual Mode)
xmap <C-F>s <Plug>CtrlSFVwordPath
" (Ctrl-F + f) Perform search with selection (Visual Mode)
xmap <C-F>f <Plug>CtrlSFVwordExec
" (Ctrl-F + w) Open search prompt with current word (Normal Mode)
nmap <C-F>w <Plug>CtrlSFCwordPath
" (Ctrl-F + o )Open CtrlSF window (Normal Mode)
nnoremap <C-F>o :CtrlSFOpen<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
nnoremap <C-F>t :CtrlSFToggle<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"End Ctrlsf stuff

lua <<EOF

require('nvim-treesitter.configs').setup({
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true },
    autotag = { enable = true },
    endwise = { enable = true },
})

EOF
