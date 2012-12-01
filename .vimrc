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

" tool
NeoBundle 'Shougo/vimshell'
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

" 行番号を表示
set number

" エンコーディング
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1

" ○
set ambiwidth=double

" 補完
set wildmode=longest:full,full
set wildmenu
set completeopt=menu,preview,longest,menuone
set complete=.,w,b,u,k

set scrolloff=15

set nobackup

set autoread

" インデント
set expandtab
set softtabstop=4 tabstop=4 shiftwidth=4
set autoindent smartindent
" set copyindent
" set preserveindent

" backspace で改行とかも削除できるように
set backspace=indent,eol,start

" 行頭・行末間移動を可能に
set whichwrap=b,s,h,l,<,>,[,]

" 対応する括弧を表示
set showmatch

" 入力中のコマンドを表示
set showcmd

" ステータスを表示
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{GitBranch()!=''?'['.GitBranch().']':''}%=%l,%c%V%8P
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 検索
set ignorecase smartcase
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

autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git

" Key Mapping

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

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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

" クリップボード
if has('gui_running')
	noremap <Space>y "+y
	noremap <Space>p "+p
elseif has('mac')
	nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
	vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
	nnoremap <silent> <Space>p :.r !pbpaste<CR><CR>
	vnoremap <silent> <Space>p :r !pbpaste<CR><CR>
endif

let mapleader=' '

let g:filetype_m = 'objc'

let g:SimpleJsIndenter_BriefMode = 1

" カーソル位置の highlight グループを取得する
command! -nargs=0 GetHighlightingGroup echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'

nmap <Space>hg :GetHighlightingGroup<CR>

function! CountLines()
    let i = 1
    let c = 0
    while i <= line("$")
         if getline(i) !~ "^\s*$" && synIDattr(synID(i, 1, 0), "name") !~ ".*Comment$"
             let c = c + 1
         endif
         let i = i + 1
     endwhile
    return c
endfunction
command! -nargs=0 CountLines echo CountLines()
nmap ,l :CountLines<CR>

" iTerm のタブにタイトルを設定
function! SetTabTitle()
	let t = expand("%:t")
	if t == ""
		silent! execute '!echo -n "\e]1;vim\a"'
	elseif t !~ "^\[A-Za-z0-9\]*://"
		silent! execute '!echo -n "\e]1;'. t . ' — vim\a"'
	endif
endfunction

if &term =~ "xterm-256color" "iTerm.app
	autocmd BufEnter * call SetTabTitle()
endif
