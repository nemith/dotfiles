"Facebook'isms
if filereadable("/etc/fbwhoami")
	source $ADMIN_SCRIPTS/master.vimrc

	" Facebook file types written in python
	autocmd BufNewFile,BufRead *.tw,*.cinc,*.cconf,*.thrift-cvalidator,*.ctest,TARGETS set filetype=python
endif

" Workaround for https://github.com/neovim/neovim/issues/3496
silent !mkdir -p ~/.local/share/nvim/backup /dev/null 2>&1

" Font (if GUI)
if has("gui_macvim") || has("gui_vimr")
	set guifont=Monaco\ for\ Powerline:h10
endif

" Solarized Color
let g:solarized_termcolors=256
colorscheme solarized

"
set number
set modelines=5

" Mouse
set mouse=a   		"enable mouse
set mousehide 		"hide when characters are typed

" Keys
nnoremap ; :
nnoremap <silent> <F5> :set invnumber<cr>

" Heresy
map <C-a> <Home>
map <C-e> <End>

nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
inoremap <C-t> <Esc>:tabnew<CR>
inoremap <C-b> <Esc>:tabprevious<CR>i
inoremap <C-n> <Esc>:tabnext<CR>i

" Golang
let g:go_fmt_command = "goimports"

"Remove trailing whitespace
autocmd BufWritePre * silent! :%s/\s\+$//e


" vim-go
let g:go_fmt_command = "goimports"

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

" indentLine
let g:indentLine_char = '┆'
let g:indentLine_color_term = 236

" NERDTreeTabs
nnoremap <silent> <F2> :NERDTreeTabsFind<CR>
noremap <F3> :NERDTreeTabsToggle<CR>
