" Maintainer: Yasuhiro Fuse
" Last Change: 25 Jan 2009

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="twilight256"

hi Normal         ctermfg=255          ctermbg=233
hi Cursor         ctermfg=255          ctermbg=248
hi CursorIM       ctermfg=255          ctermbg=172
hi Directory      ctermfg=101          ctermbg=233
hi ErrorMsg       ctermfg=173          ctermbg=52
hi VertSplit      ctermfg=137          ctermbg=231
hi Folded         ctermfg=230          ctermbg=238
hi IncSearch      ctermfg=0            ctermbg=167
hi LineNr         ctermfg=110          ctermbg=0
hi ModeMsg        ctermfg=172          ctermbg=222
hi MoreMsg        ctermfg=172          ctermbg=222
hi NonText        ctermfg=181          ctermbg=233
hi Question       ctermfg=230          ctermbg=238
hi Search         ctermfg=52           ctermbg=173
hi SpecialKey     ctermfg=172          ctermbg=233
hi StatusLine     ctermfg=238          ctermbg=230
hi StatusLineNC   ctermfg=67           ctermbg=255
hi Title          ctermfg=230          ctermbg=236
hi Visual         ctermfg=236          ctermbg=110
hi WarningMsg     ctermfg=173          ctermbg=52
hi WildMenu       ctermfg=230          ctermbg=238

"Syntax hilight groups

hi Comment        ctermfg=101
hi Constant       ctermfg=209
hi String         ctermfg=193
hi Character      ctermfg=179
hi Number         ctermfg=139
hi Boolean        ctermfg=167
hi Float          ctermfg=139
hi Identifier     cterm=NONE ctermfg=110
hi Function       ctermfg=101
hi Statement      cterm=bold ctermfg=172
hi Conditional    ctermfg=181
hi Repeat         ctermfg=228
hi Label          ctermfg=179
hi Operator       ctermfg=209
hi Keyword        ctermfg=179
hi Exception      ctermfg=228
hi PreProc        ctermfg=101
hi Include        ctermfg=101
hi Define         ctermfg=228
hi Macro          ctermfg=94
hi PreCondit      ctermfg=186
hi Type           cterm=bold ctermfg=186
hi StorageClass   ctermfg=180
hi Structure      ctermfg=136
hi Typedef        ctermfg=186
hi Special        ctermfg=209
hi SpecialChar    ctermfg=136
hi Tag            ctermfg=186
hi Delimiter      ctermfg=136
hi SpecialComment ctermfg=168
hi Debug          ctermfg=brown
hi Underlined     ctermfg=167
hi Ignore         ctermfg=238
hi Error          ctermfg=173 ctermbg=52
hi Todo           ctermfg=110 ctermbg=24
hi Pmenu          ctermfg=233 ctermbg=179
hi PmenuSel       ctermfg=255 ctermbg=130
hi PmenuSbar      ctermbg=193
hi PmenuThumb     ctermfg=65
hi MatchParen     ctermfg=37
