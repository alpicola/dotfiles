set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" core
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

" unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shogo/unite-outline'
NeoBundle 'eagletmt/unite-haddock'

" input
NeoBundle 'Shougo/neocomplcache', 'c36f1e177989560edb1ccfc2d1b89359e3833ef5'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'

" filetype
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'VimClojure'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'grafi-tt/vim-filetype-haskell'

" tool
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'motemen/git-vim'

" doc
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ref'

filetype plugin on
filetype indent on

syntax on

if &term =~ "xterm-256color"
	colorscheme twilight256
elseif &term =~ "xterm-color"
    set t_Co=16
	colorscheme twilight16
endif

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set ambiwidth=double
set wildmode=longest:full,full
set wildmenu
set completeopt=menu,preview,longest,menuone
set complete=.,w,b,u,k
set scrolloff=15
set nobackup
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
set nohlsearch
set hidden
set lazyredraw
set winwidth=80
set splitbelow
set splitright
set imdisable
set iminsert=0
set imsearch=0
set mouse=a
set modeline
set lispwords-=if
set directory=~/.vim/tmp
set swapfile

if has('conceal')
  set conceallevel=2
  set concealcursor=i
endif

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

let mapleader=' '

let g:filetype_m = 'objc'

let g:SimpleJsIndenter_BriefMode = 1

autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up> gk
nmap <C-J> <C-D>
nmap <C-K> <C-U>
vnoremap / /\%V
vnoremap ? ?\%V
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprev<CR>

command! -nargs=0 GetHighlightingGroup echo
    \ 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') .
    \ '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') .
    \ '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'
nmap <Space>hg :GetHighlightingGroup<CR>

" clipboard
noremap <Space>y "*Y
noremap <Space>p "*p
vnoremap <Space>y "*y
vnoremap <Space>p "*p

" vimshell
vmap <silent> <Space>s :VimShellSendString<CR>
nnoremap <silent> <Space>s :VimShellSendString<CR>

" quickrun.vim
let g:quickrun_config = {
    \   '_' : {
    \       'runner' : 'vimproc',
    \       'runner/vimproc/updatetime' : 40,
    \       'outputter/buffer/split' : 'below 10sp',
    \   },
    \   'egison' : {
    \       'command' : 'egisonc',
    \       'exec': ['%c %o --test %s', '%s:p:r'],
    \       'tempfile': '%{tempname()}.egi',
    \       'hook/sweep/files': '%S:p:r',
    \   },
    \}
nmap <silent> <Space>r :QuickRun -split 'rightbelow 10'<CR>
nmap <silent> <Space>R :QuickRun -split 'rightbelow vertical'<CR>

" unite.vim
let g:unite_enable_start_insert = 1
nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>ud :<C-u>Unite file_rec<CR>
nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Space>um :<C-u>Unite file_mru<CR>
nnoremap <silent> <Space>uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <Space>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru<CR>
nnoremap <silent> <Space>uo :<C-u>Unite outline<CR>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
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

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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

" ghcmod
nmap <Space>ht :GhcModType<CR>
nmap <Space>hT :GhcModTypeClear<CR>
nmap <Space>hc :GhcModCheck<CR>
nmap <Space>hl :GhcModLint<CR>
nmap <Space>he :GhcModExpand<CR>
