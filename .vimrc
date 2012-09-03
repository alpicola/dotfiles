set nocompatible
syntax on

filetype on
filetype plugin on
filetype indent on

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
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" ○
set ambiwidth=double

" 補完
set wildmode=longest,list
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
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 検索
set ignorecase smartcase
set incsearch
set wrapscan

set nohlsearch

set hidden

set lazyredraw

" IM は無効に
set imdisable
set iminsert=0
set imsearch=0

set mouse=a

set modeline

augroup MyAutoCmd
	autocmd!
augroup END

autocmd MyAutoCmd BufReadPost *
	\   if &modifiable && !search('[^\x00-\x7F]', 'cnw')
	\ |   setlocal fileencoding=
	\ | endif

autocmd MyAutoCmd BufNewFile,BufRead *.as set filetype=actionscript
autocmd MyAutoCmd BufNewFile,BufRead *.mxml set filetype=mxml
autocmd MyAutoCmd BufNewFile,BufRead *.ru set filetype=ruby
autocmd MyAutoCmd BufNewFile,BufRead *.pde set filetype=processing
autocmd MyAutoCmd BufNewFile,BufRead *.spde set filetype=scala
autocmd MyAutoCmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git

" filetype off
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" filetype plugin on

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

" バッファ切替
nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprev<CR>

" vimshell
vmap <silent> <Space>s :VimShellSendString<CR>
nnoremap <silent> <Space>s :VimShellSendString<CR>

" quickrun.vim
nmap <Space>r :QuickRun -split 'rightbelow 10'<CR>
nmap <Space>R :QuickRun -split 'rightbelow vertical'<CR>

" fuf.vim
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_file_exclude = '\v\.DS_Store|\.git|\.svn|\.(swp|swo|bak|gif|jpg|png|bmp)$'
let g:fuf_mrufile_exclude = '\v\.DS_Store|\.git|\.svn|\.swp$'
let g:fuf_mrufile_maxItem = 100
nmap <Space>fb :FufBuffer<CR>
nmap <Space>fd :FufDir<CR>
nmap <Space>ff :FufFile **/<CR>
nmap <Space>fc :FufFile<C-R>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nmap <Space>fl :FufLine<CR>
nmap <Space>fm :FufMruFile<CR>
nmap <Space>fq :FufQuickfix<CR>

" neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_lock_buffer_name_pattern = 'fuf'
let g:neocomplcache_plugin_disable = {
  \ 'syntax_complete' : 1,
  \ 'tags_complete' : 1,
  \ }
let g:neocomplcache_text_mode_filetypes = {}
let g:neocomplcache_text_mode_filetypes.markdown = 1
let g:neocomplcache_plugin_rank = {}
let g:neocomplcache_plugin_rank.buffer_complete = 15
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

" カーソル位置の highlight グループを取得する
command! -nargs=0 GetHighlightingGroup echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'

nmap <Space>hg :GetHighlightingGroup<CR>

let g:SimpleJsIndenter_BriefMode = 1

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

let g:filetype_m = 'objc'
