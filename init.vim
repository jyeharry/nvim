
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

" Tips for using help:
" :h :command                         help for ex-command 'command'
" :h 'option'                         help for option 'option'
" :h function()                       help for function 'function'
" :h modifier-key                     help for 'modifier'-'key' in normal mode
" :h mode_modifier-key                help for 'modifier'-'key' in 'mode'
" :h mode_modifier-key_modifier-key   help for 'modifier'-'key' 'modifier'-'key' in 'mode'

" Examples for the above:
" :h :sort
" :h 'ai                " only one quote needed
" :h bufnr(             " no need for both parenthesis
" :h v_ctrl-g
" :h i_ctrl-x_ctrl-o
" :h ctrl-w             " no mode required for normal mode


" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

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

set timeoutlen=750

set ignorecase
set smartcase

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup end

set foldmethod=indent
nnoremap <space> za
set nofoldenable
set foldlevel=999

" Restore last cursor position
autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

" Close all folds to cursor position
nnoremap zz :let &l:foldlevel = indent('.') / &shiftwidth<CR>zm

" Shift tab to complete word
inoremap <S-Tab> <C-P>

" Use Shift-k/j to move line up or down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Down> :m '>+1<CR>gv=gv

" File wide search and replace with very magic and global flag
nnoremap <leader>sr :%s/\v//g<Left><Left><Left>
" File wide search and replace for highlighted word with global flag
vnoremap <leader>sr y:%s/<C-R>=escape(@",'/')<CR>//g<Left><Left>

" Paste over selected text without yanking
vnoremap p "0p
" Paste at matching indentation
nnoremap p p=`]

nnoremap U <C-R>

nnoremap H ^
nnoremap L $
onoremap H ^
onoremap L $

" Map key chord `jk` to <Esc>.
let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key ==# 'j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key ==# 'k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
	let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
	return (l:timediff <= 0.05 && l:timediff >=0.001) ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

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

set mouse-=nvi

set linebreak

set encoding=utf-8

set wildmenu
set wildmode=longest:full,full

set laststatus=2

set autoindent
set smartindent

set number
set relativenumber
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

vnoremap // y/\v<C-R>=escape(@",'=/\.?*+^$[]{}()@<>')<CR><CR>
nnoremap / /\v

set cursorline

set background=dark

set t_Co=256

set updatetime=100

set notildeop

set shada+=%,

set path=.,**

" Ignore certain files and directories when searching
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
set wildignore+=*/node_modules/**/*,*/dist/**/*
set wildignore+=**/node_modules/**/*,*/dist/**/*
set wildignorecase

" Cycle buffers
set wildcharm=<C-z>
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <C-h>   :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap gb :ls<CR>:b<Space>
nnoremap gsb :ls<CR>:sb<Space>

" A command to make invocation easier
command! -complete=buffer -nargs=+ BD call BDelete(<f-args>)

function! BDelete(...)
    let bufnames = []
    " Get a list of all the buffers
    for bufnumber in range(0, bufnr('$'))
        if buflisted(bufnumber)
            call add(bufnames, bufname(bufnumber))
        endif
    endfor
    for argument in a:000
        " Escape any backslashes, dots or spaces in the argument
        let this_argument = escape(argument, '\ .')
        " Turn * into .* for a regular expression match
        let this_argument = substitute(this_argument, '\*', '.*', '')

        " Iterate through the buffers
        for buffername in bufnames
            " If they match the provided regex and the buffer still exists
            " delete the buffer
            if match(buffername, this_argument) != -1 && bufexists(buffername)
                exe 'bdelete' buffername
            endif
        endfor
    endfor
endfunction

" Break text surrounded by symbols such as brackets onto new lines using ', ' as point of line break
nnoremap <leader>br :s/\v^(\s*)(.*)([\[\(\{\<])(.*)([\)\]\}\>])/\1\2\3\r\1\t\4\r\5/<CR>k:s/\v(\s*)(\w)*, /\1\2,\r\t/g<CR>jb%:noh<CR>

function! Mv(...)
  let new_name = get(a:, 1, '')
  let old_path = expand('%:p')

  if stridx(new_name, '/') == 0
    let new_path = new_name
  elseif stridx(new_name, '.') == 0 && (stridx(new_name, '/') == 1 || new_name[1] == '.' && new_name[2] == '/')
    let new_path = getcwd() . '/' . new_name
  else
    let new_path = expand('%:p:h') . '/' . new_name
  endif

  if filereadable(new_path)
    echo "File with that name already exists"
    return
  endif

  exe 'saveas! ' . fnameescape(new_path)
  exe 'bd! ' . bufnr(old_path)
  call delete(old_path)
endfunction

command! -nargs=1 -complete=file Mv call Mv(<f-args>)
nnoremap <leader>Mv :Mv <C-R>=expand('%:p')<CR>

" Quickly resize current window width (works same as z{nr}<CR> for changing window height; v is for vertical)
nnoremap zv :vertical resize 

set virtualedit=all

" Close vim if quickfix window is last remaining window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" Close quickfix window when selecting item from list
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

function! HlSearch()
    let s:pos = match(getline('.'), @/, col('.') - 1) + 1
    "echom s:pos . '|' . col('.')
    if s:pos != col('.')
        call StopHL()
    endif
endfu

function! StopHL()
    if !v:hlsearch
        return
    else
        call feedkeys("\<Plug>(StopHL)", "m")
    endif
endfunction

augroup SearchHighlight
au!
    au CursorMoved * call HlSearch()
    au InsertLeave * call StopHL()
augroup end

" This prevents nvim from creating a no name buffer when running nvim without arguments
autocmd VimEnter * if argc() == 0 | silent! bdelete | endif
function! DetectFileType()
  if &filetype == ""
    filetype detect
    filetype plugin on
    filetype plugin indent on
  endif
endfunction
autocmd BufEnter * call DetectFileType()
autocmd VimEnter * call DetectFileType()

" make list-like commands more intuitive
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction

cnoremap <expr> <CR> CCR()

autocmd BufLeave * if &buftype=="terminal" | setlocal nobuflisted | endif

set clipboard=unnamedplus

" Put plugins here
call plug#begin()
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'tpope/vim-surround'

  Plug 'ludovicchabant/vim-gutentags'

  Plug 'jremmen/vim-ripgrep'

  Plug 'lukas-reineke/indent-blankline.nvim'

  Plug 'vim-test/vim-test'

  Plug 'tpope/vim-commentary'

  Plug 'tpope/vim-rails'

  Plug 'nvim-lua/plenary.nvim'

  Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}

  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  Plug 'nvim-telescope/telescope-live-grep-args.nvim'

  Plug 'ahmedkhalf/project.nvim'

  Plug 'williamboman/mason.nvim'

  Plug 'williamboman/mason-lspconfig.nvim'

  Plug 'neovim/nvim-lspconfig'
  
  Plug 'tamago324/nlsp-settings.nvim'

  Plug 'jose-elias-alvarez/null-ls.nvim'

  Plug 'hrsh7th/nvim-cmp'

  Plug 'hrsh7th/cmp-nvim-lsp'

  Plug 'hrsh7th/cmp-buffer'

  Plug 'hrsh7th/cmp-path'

  Plug 'hrsh7th/cmp-cmdline'

  Plug 'hrsh7th/cmp-vsnip'

  Plug 'hrsh7th/vim-vsnip'

  Plug 'onsails/lspkind.nvim'

  Plug 'nvim-tree/nvim-web-devicons'

  Plug 'jay-babu/mason-null-ls.nvim'

  Plug 'rafamadriz/friendly-snippets'

  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

  Plug 'JoosepAlviste/nvim-ts-context-commentstring'

  Plug 'nvim-tree/nvim-tree.lua'

  Plug 'SmiteshP/nvim-navic'

  Plug 'nvim-lualine/lualine.nvim'

  Plug 'utilyre/barbecue.nvim'

  Plug 'windwp/nvim-autopairs'

  Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.*' }

  Plug 'lewis6991/gitsigns.nvim'

  Plug 'RRethy/vim-illuminate'

  Plug 'folke/which-key.nvim'

  Plug 'windwp/nvim-ts-autotag'

  Plug 'github/copilot.vim'
call plug#end()

inoremap <silent><script><expr> <C-CR> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
inoremap <C-j> <Plug>(copilot-next)
inoremap <C-k> <Plug>(copilot-previous)

let os = substitute(system('uname'), '\n', '', '')
if os ==# 'Linux'
  nmap <C-_> gccj
  vmap <C-_> gc
else
  nmap <C-/> gccj
  vmap <C-/> gc
endif

" :edit but with path to files directory
nnoremap <leader>e :edit <C-R>=expand('%:p:h').'/'<CR>

let b:commentary_startofline = 1

let g:context_max_height = 11

set signcolumn=yes

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable

nnoremap <C-p> :NvimTreeFindFileToggle<CR>
nnoremap <leader>rf :NvimTreeRefresh<CR>

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:gutentags_cache_dir = '~/.local/share/nvim/tags/'

highlight IndentBlanklineChar guifg=#2a3c47 gui=nocombine
highlight IndentBlanklineContextChar guifg=#425e6f gui=nocombine

let test#strategy = 'neovim'
let g:test#neovim#start_normal = 1

nnoremap <C-g> :Gitsigns next_hunk<CR>
nnoremap <C-S-g> :Gitsigns prev_hunk<CR>

lua <<EOF

require("nvim-autopairs").setup()

require('nvim-treesitter.configs').setup({
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Enter>",
      node_incremental = "<Enter>",
      node_decremental = "<BS>",
    },
  },
})

require("project_nvim").setup({
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  detection_methods = { "lsp", "pattern" },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {},

  -- Don't calculate root dir on specific directories
  -- Ex: { "~/.cargo/*", ... }
  exclude_dirs = {},

  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = true,

  -- What scope to change the directory, valid options are
  -- * global (default)
  -- * tab
  -- * win
  scope_chdir = 'global',

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath("data"),
})

local lga_actions = require("telescope-live-grep-args.actions")
local telescope = require('telescope')

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('v', '<leader>fg', function()
	local text = vim.getVisualSelection()
  telescope.extensions.live_grep_args.live_grep_args({ default_text = text })
end, opts)

telescope.load_extension('projects')

telescope.setup({
  pickers = {
    find_files = {
      hidden = true
    },
  },
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--hidden",
      "--smart-case",
      "--trim",
      "--glob",
      "!.git*"
    }
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-o>"] = lga_actions.quote_prompt(),
        },
      },
    },
  }
})

require("indent_blankline").setup({
    show_current_context = true,
})

vim.cmd[[colorscheme tokyonight-night]]

require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = true,
})

local navic = require('nvim-navic')

require("mason-lspconfig").setup_handlers {
  function (server_name)
    require("lspconfig")[server_name].setup({
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end
    })
  end,
}

vim.diagnostic.config({
  float = {
    border = 'rounded',
    header = '',
  }
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded'
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded'
})

require('nvim-ts-autotag').setup()

local lspconfig = require("lspconfig")

vim.keymap.set('n', '<leader>g', vim.diagnostic.open_float)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

local nlspsettings = require("nlspsettings")

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers_fallback = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

local global_capabilities = vim.lsp.protocol.make_client_capabilities()
global_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  capabilities = global_capabilities,
})

require("mason-null-ls").setup({
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
    handlers = {},
})
require("null-ls").setup()

local cmp = require'cmp'

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
    end
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({
    filetypes = {
      -- "*" is a alias to all filetypes
      ["*"] = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          handler = handlers["*"]
        }
      },
    }
  })
)

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('nvim-tree').setup({ open_on_setup = true })

require("barbecue").setup({
  exclude_filetypes = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
  },
  show_modified = true
})

require('lualine').setup {
  options = {
    theme = 'tokyonight',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'diagnostics'},
    lualine_z = {'progress', '%l/%L:%c'}
  },
}

require"bufferline".setup({
  options = {
    numbers = "buffer_id",
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  }
})

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 250,
    ignore_whitespace = true,
  },
  numhl = true,
})

vim.keymap.set('n', '<C-n>', require('illuminate').goto_next_reference, { desc = "Move to next reference" })
vim.keymap.set('n', '<C-S-n>', require('illuminate').goto_prev_reference, { desc = "Move to previous reference" })

local wk = require("which-key")
wk.register({
  ['<leader>'] = {
    f = {
      name = 'Find',
      f = { '<cmd>Telescope find_files<cr>', 'Files' },
      g = { '<cmd>lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>', 'Grep' },
      b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help Tags' },
      p = { '<cmd>Telescope projects<cr>', 'Projects' },
    },
    F = { '<cmd>Telescope resume<cr>', 'Resume Find' },
    p = { '<cmd>lua vim.lsp.buf.format()<CR>', 'Format' },
    g = {
      name = 'Git',
      d = { '<cmd>Gitsigns diffthis<CR><cmd>wincmd w<CR>', 'Diff' }, 
      h = {
        name = 'Hunk',
        p = { '<cmd>Gitsigns preview_hunk_inline<CR>', 'Preview' },
        r = { '<cmd>Gitsigns reset_hunk<CR>', 'Reset' },
        s = { '<cmd>Gitsigns stage_hunk<CR>', 'Stage' },
        u = { '<cmd>Gitsigns undo_stage_hunk<CR>', 'Undo Stage' },
        v = { '<cmd>Gitsigns select_hunk<CR>', 'Select' },
      }, 
    },
    y = {
      name = 'Yank',
      ap = { "<cmd>let @+=expand('%:p')<CR>:echo 'Copied absolute path'<CR>", 'Absolute Path' },
      rp = { "<cmd>let @+=expand('%:.')<CR>:echo 'Copied relative path'<CR>", 'Relative Path' },
      dir = { "<cmd>let @+=expand('%:h')<CR>:echo 'Copied directory name'<CR>", 'Directory Name' },
      fn = { "<cmd>let @+=expand('%:t')<CR>:echo 'Copied filename'<CR>", 'Filename' },
    },
  }
})

EOF

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
