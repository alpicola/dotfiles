setlocal omnifunc=necoghc#omnifunc
setlocal tabstop=2 softtabstop=2 shiftwidth=2
setlocal iskeyword+='

" ghcmod
nmap <buffer> <Space>t :GhcModType<CR>
nmap <buffer> <Space>T :GhcModTypeClear<CR>
