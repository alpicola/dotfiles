" template.vim
"
" Author:  Yasuhiro Fuse
" Version: 0.1
" Licence: MIT Licence

if exists("g:loaded_template")
	finish
endif
let g:loaded_template = 1

if !exists("s:base_dir")
	let s:base_dir = substitute(expand("<sfile>:p:h"), '[/\\]plugin$', '', '')
endif

function! s:LoadTemplate(ext)
	let ext = a:ext == 0 ? expand("%:e") : a:ext
	let path = s:base_dir . "/template/skelton" . ext
	if !filereadable(path)
		echoerr path . " does not exist"
		return
	endif
endfunction

command! -nargs=? Template :call <SID>LoadTemplate(<f-args>)

