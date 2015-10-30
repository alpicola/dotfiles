setlocal tabstop=2 softtabstop=2 shiftwidth=2
" coquille
let g:coquille_auto_move = 'true'
nmap <buffer> <Space>c :CoqLaunch<CR>
nmap <buffer> <Esc>n <M-n>
nmap <buffer> <Esc>p <M-p>
nmap <buffer> <Esc>h <M-h>
nmap <buffer> <M-n> :CoqNext<CR>
nmap <buffer> <M-p> :CoqUndo<CR>
nmap <buffer> <M-h> :CoqToCursor<CR>
