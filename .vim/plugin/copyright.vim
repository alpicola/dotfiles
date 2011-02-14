" copyright.vim - Insert information of license
"
" Author:  Yasuhiro Fuse
" Version: 0.1
" Licence: MIT Licence

if exists("g:loaded_copyright")
	finish
endif
let g:loaded_copyright = 1

if !exists("g:copyright_author")
	let g:copyright_author = "your name"
endif

if !exists("s:base_dir")
	let s:base_dir = substitute(expand("<sfile>:p:h"), '[/\\]plugin$', '', '')
endif

function! s:InsertLicense(license)
	let path = s:base_dir . "/license/" . a:license
	if !filereadable(path)
		echoerr path . " does not exist"
		return
	endif

	if &ft =~ '^\(actionscript\|c\|cpp\|cs\|css\|d\|io\|java\|javascript\|' .
	        \ 'php\|scala\|objc\|objcpp\|yacc\)$'
		let comment = ['/*', ' *', '*/']
	elseif &ft =~ '^\(html\|xhtml\|xml\|xslt\|xsd\|dtd\)$'
		let comment = ['<!--', '  ', '-->']
	elseif &ft =~ '^\(lisp\|scheme\)$'
		let comment = [';', ';', ';']
	elseif &ft =~ '^\(python\|perl\|ruby\|[^w]*sh\|tcl\|make\)$'
		let comment = ['#', '#', '#']
	elseif &ft =~ '^\(erlang\|tex\)$'
		let comment = ['%', '%', '%']
	elseif &ft =~ '^\(vb\|basic\)$'
		let comment = ["'", "'", "'"]
	elseif &ft =~ '^\(ada\|eiffel\|haskell\|lua\)$'
		let comment = ['--', '--', '--']
	elseif &ft == 'ocaml'
		let comment = ['(*', ' ', '*)']
	elseif &ft == 'vim'
		let comment = ['"', '"', '"']
	else
		let comment = ['', '', '']
	endif

	let lines = []
	call add(lines, "Licenced under the " . a:license . " license")
	call add(lines, "")
	call add(lines, "Copyright (c) " . strftime("%Y") . " " . g:copyright_author)
	call add(lines, "")
	call extend(lines, readfile(path))
	call map(lines, 'comment[1] . " " . v:val')
	call insert(lines, comment[0])
	call add(lines, comment[2]) 
	call append(line("."), lines)
endfunction

command! -nargs=1 License :call <SID>InsertLicense(<f-args>)

