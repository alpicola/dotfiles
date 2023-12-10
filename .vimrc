set nocompatible
filetype off

call plug#begin()

" unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'tsukkee/unite-tag'

" input
Plug 'Shougo/neocomplcache'
Plug 'ujihisa/neco-look'

" filetype
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'
Plug 'wting/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'plasticboy/vim-markdown'
Plug 'motemen/hatena-vim'
Plug 'vim-python/python-syntax'
Plug 'hashivim/vim-terraform'
Plug 'uarun/vim-protobuf'

" tools
Plug 'motemen/git-vim'

" doc
Plug 'thinca/vim-ref'

call plug#end()

filetype plugin on
filetype indent on

syntax on

set background=dark
set t_Co=16
colorscheme twilight16

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set ambiwidth=single
set wildmode=longest:full,full
set wildmenu
set completeopt=menu,preview,longest,menuone
set complete=.,w,b,u,k
set scrolloff=15
set autoread
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set autoindent
set nosmartindent
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set number
set showmatch
set showcmd
set showmode
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{GitBranch()!=''?'['.GitBranch().']':''}%=%l,%c%V%8P
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set hidden
set nolazyredraw
set winwidth=80
set splitbelow
set splitright
set imdisable
set iminsert=0
set imsearch=0
set mouse=a
set modeline
set lispwords-=if
set nobackup
set directory=~/.vim/tmp/swap//
set swapfile
if has('persistent_undo')
  set undodir=~/.vim/tmp/undo//
  set undofile
endif

let mapleader=','
let maplocalleader='\'
let g:vim_indent_cont = &sw
let g:filetype_m = 'matlab' " or objc
let g:filetype_pl = 'perl' " or prolog
let g:asmsyntax = 'ppc'
let g:tex_flavor = 'latex'

nnoremap ; :
nnoremap : ;
noremap <Space> <Nop>
nnoremap <silent> H ^
nnoremap <silent> L $
nnoremap <silent> J gj
nnoremap <silent> K gk
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up> gk
nnoremap <silent> <C-j> <C-d>
nnoremap <silent> <C-k> <C-u>
nnoremap <silent> <C-L> :noh<CR><C-L>
vnoremap / /\%V
vnoremap ? ?\%V
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

" like vimperator
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :bprev<CR>

" clipboard
noremap <Space>y "*Y
noremap <Space>p "*p
vnoremap <Space>y "*y
vnoremap <Space>p "*p

" unite.vim
let g:unite_enable_start_insert = 1
let g:unite_enable_auto_select = 0
nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>ud :<C-u>Unite file_rec<CR>
nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Space>um :<C-u>Unite file_mru<CR>
nnoremap <silent> <Space>ut :<C-u>Unite tag<CR>
nnoremap <silent> <Space>uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <Space>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru<CR>
nnoremap <silent> <Space>uo :<C-u>Unite outline<CR>

" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_text_mode_filetypes = {}
let g:neocomplcache_text_mode_filetypes.markdown = 1
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR>  pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
nnoremap <Space>nc :NeoComplCacheCachingBuffer<CR>

" git.vim
nmap <Space>ga :GitAdd<CR>
nmap <Space>gA :GitAdd .<CR>
nmap <Space>gc :GitCommit<CR>
nmap <Space>gC :GitCommit --amend<CR>
nmap <Space>gd :GitDiff --cached<CR>
nmap <Space>gD :GitDiff<CR>
nmap <Space>gl :GitLog<CR>
nmap <Space>gL :GitLog -u<CR>
nmap <Space>gp :GitPush<CR>
nmap <Space>gP :GitPull<CR>
nmap <Space>gs :GitStatus<CR>
