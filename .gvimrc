
set lines=40
set columns=100

colorscheme twilight2

if has("gui_macvim")
	set showtabline=2
	set antialias
	set transparency=10
	set guioptions-=T
elseif has("gui_mac")
	set gfn=DejaVuSansMono:h12
	set gfw=DejaVuSansMono:h12
	" set gfw=Osaka-Mono:h14
	" set macatsui
	set antialias
	set transparency=240

	map <D-w> :q<CR>gT
	map <D-t> :tabnew<CR>
	map <D-n> :new<CR>
	map <D-S-t> :browse tabe<CR>
	map <D-S-n> :browse split<CR>
	map <D-]> :tabn<CR>
	map <D-[> :tabp<CR>
	map <D-M-Right> :tabn<CR>
	map <D-M-Left> :tabp<CR>
	imap <D-M-Right> <C-o>:tabn<CR>
	imap <D-M-Left> <C-o>:tabp<CR>
els
	set gfn=Source\ Code\ Pro\ 13
	set gfw=Source\ Code\ Pro\ 13
	set guioptions-=T
	" set gfw=DejaVuSansMono:h12
end

