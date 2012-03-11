
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

" 行番号表示
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

set autoindent smartindent

" backspace で改行とかも削除できるように
set backspace=indent,eol,start

" 行頭・行末間移動を可能に
set whichwrap=b,s,h,l,<,>,[,]

" タブ
set expandtab
set softtabstop=4 tabstop=4 shiftwidth=4
" set copyindent
" set preserveindent

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
autocmd MyAutoCmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git | AutoComplPopDisable

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

" quickrun.vim
nmap <Space>r :QuickRun -split 'rightbelow 10'<CR>
nmap <Space>R :QuickRun -split 'rightbelow vertical'<CR>

" FuzzyFinder
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

" Git
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

function! ShebangExecute()
	let m = matchlist(getline(1), '#!\(.*\)')
	if(len(m) > 2)
		execute '!'. m[1] . ' %'
	else
		execute '!' &ft ' %'
	endif
endfunction

nmap ,e :call ShebangExecute()<CR>

" カーソル位置の highlight グループを取得する
command! -nargs=0 GetHighlightingGroup echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'

nmap ,hg :GetHighlightingGroup<CR>

" {{{ Autocompletion using the TAB key

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
	if pumvisible()
		return "\<C-N>"
	else
		let col = col('.') - 1
		if !col || getline('.')[col - 1] =~ '\k'
			return "\<C-N>\<C-P>"
		else
			return "\<TAB>"
		endif
	endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>

" }}} Autocompletion using the TAB key

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
