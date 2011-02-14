" Maintainer: Yasuhiro Fuse
" Last Change: 25 Jan 2009

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="twilight16"

hi Normal         ctermfg=15         ctermbg=0
" hi Cursor         ctermfg=255          ctermbg=248
" hi CursorIM       ctermfg=255          ctermbg=172
" hi Directory      ctermfg=3          ctermbg=233
hi ErrorMsg       ctermfg=1          ctermbg=3
" hi VertSplit      ctermfg=137          ctermbg=231
" hi Folded         ctermfg=230          ctermbg=8
hi IncSearch      ctermfg=0          ctermbg=1
hi LineNr         ctermfg=4          ctermbg=0
" hi ModeMsg        ctermfg=172          ctermbg=222
" hi MoreMsg        ctermfg=172          ctermbg=222
" hi NonText        ctermfg=181          ctermbg=233
" hi Question       ctermfg=230          ctermbg=8
hi Search         ctermfg=1          ctermbg=0
" hi SpecialKey     ctermfg=172          ctermbg=233
hi StatusLine     ctermfg=8          ctermbg=4
hi StatusLineNC   ctermfg=4          ctermbg=15
" hi Title          ctermfg=230          ctermbg=8
hi Visual         ctermfg=8          ctermbg=4
hi WarningMsg     ctermfg=1          ctermbg=3
" hi WildMenu       ctermfg=230          ctermbg=8

"Syntax hilight groups

hi Comment        ctermfg=2
hi Constant       ctermfg=1
hi String         ctermfg=10
" hi Character      ctermfg=179
hi Number         ctermfg=12
hi Boolean        ctermfg=1
hi Float          ctermfg=4
hi Identifier     cterm=NONE ctermfg=4
hi Function       ctermfg=2
hi Statement      cterm=bold ctermfg=13
hi Conditional    ctermfg=9
" hi Repeat         ctermfg=228
" hi Label          ctermfg=179
hi Operator       ctermfg=1
" hi Keyword        ctermfg=179
" hi Exception      ctermfg=228
hi PreProc        ctermfg=6
hi Include        ctermfg=6
hi Define         ctermfg=11
" hi Macro          ctermfg=94
hi PreCondit      ctermfg=14
hi Type           cterm=bold ctermfg=14
hi StorageClass   ctermfg=9
" hi Structure      ctermfg=136
hi Typedef        ctermfg=14
hi Special        ctermfg=1
hi SpecialChar    ctermfg=7
hi Tag            ctermfg=14
hi Delimiter      ctermfg=7
" hi SpecialComment ctermfg=168
hi Debug          ctermfg=brown
hi Underlined     ctermfg=1
" hi Ignore         ctermfg=238
hi Error          ctermfg=1 ctermbg=5
" hi Todo           ctermfg=4 ctermbg=24
hi Pmenu          ctermfg=0 ctermbg=3
hi PmenuSel       ctermfg=15 ctermbg=7
hi PmenuSbar      ctermbg=10
hi PmenuThumb     ctermfg=2
hi MatchParen     ctermfg=4
