setlocal makeprg=js\ -w\ -s\ -C\ %
setlocal errorformat=%f:%l:%m

" autocmd BufWritePost <buffer> silent make|redraw!
