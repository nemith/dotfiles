set nocompatible

" Required Vundle setup
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
"
Bundle 'gmarik/vundle'

"Bundle 'garbas/vim-snipmate'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'SirVer/ultisnips'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'chrisbra/csv.vim'
Bundle 'editorconfig/editorconfig-vim'
"Bundle 'ervandew/supertab'
Bundle 'fs111/pydoc.vim'
Bundle 'godlygeek/tabular'
Bundle 'henrik/vim-indexed-search'
Bundle 'honza/vim-snippets'
Bundle 'jiangmiao/auto-pairs'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'scottdware/vim-slax'
Bundle 'scrooloose/syntastic'
Bundle 'sickill/vim-monokai'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-pathogen'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/The-NERD-tree'
Bundle 'Shougo/neocomplete.vim'

" SCM Plugins
"Bundle 'motemen/git-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" Languge specific Plugins
Bundle 'fatih/vim-go'

" Facebook
if filereadable("/etc/fbwhoami")
    source $ADMIN_SCRIPTS/master.vimrc
endif

" syntax highlighting
syntax on
filetype on                 " enables filetype detection
filetype plugin indent on   " enables filetype specific plugins

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline_theme="powerlineish"
let g:airline#extensions#syntastic#enabled =  1

"Colors
set t_Co=256
set background=dark
"colorscheme monokai
let g:solarized_termcolors=256
colorscheme solarized

" Enable the mouse
set mouse=a

" supertab - for tab completion
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" (FUNCTION) <F1-12>commands"
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
" NedTree - file explorer
map <F3> :NERDTreeToggle<CR>
" Toggle Gundo Undo/Redo
nnoremap <F4> :GundoToggle<CR>
" Tags
nmap <F5> :TagbarToggle<CR>

" Show editing mode in status (-- INSERT --)
set showmode

" Show cursor position
set ruler

" Don't show tab or EOL chars
set nolist

" Automatically reload files when they have changed
set autoread

" Auto Indent
set ai

" Auto Indent according to the c standard
set cindent

" Show Line Numbers
set nu

" Incrimental Search
set incsearch

" Set default spacing parameters (PYTHON DEFINED SEPARATELY)
set smartindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" Show Statusline on bottom with GIT BRANCH info
set laststatus=2

" tabs
set showtabline=2  "Always show tabs
imap ,t <Esc>:tabnew<CR>
map <D-A-Right> :tabn<CR>
map <D-A-Left>  :tabp<CR>

" Autoreload vimrc on save
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Python Specific Settings
function! DoPythonSettings()
  let g:flake8_builtins="_,apply"
  let g:pyflakes_use_quickfix = 0
  " Python uses a tab stop of 4
  setlocal softtabstop=4
  setlocal tabstop=4
  setlocal shiftwidth=4

  " Remove whitespace before and after brackets
  silent! %s/\([^ #]\)[ ]\+)/\1)/g
  silent! %s/([ ]\+\([^ ]\)/(\1/g
  silent! %s/\([^ #]\)[ ]\+\]/\1]/g
  silent! %s/\[[ ]\+\([^ ]\)/[\1/g

  " Fix Dictionary lint
  silent! %s/\("\|'\)[ ]\+:[ ]*\([^ ]\)/\1: \2/g
  silent! %s/\("\|'\)[ ]*: [ ]\+\([^ ]\)/\1: \2/g

  " Fix iterator lint
  silent! %s/^\([ ]*for [^ ]\+,\)\([^ ]\+ in\)/\1 \2/g

  setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

  " Comment and uncomment
  command! -range C <line1>,<line2> s/\(.*\)/#\1/g
  command! -range U <line1>,<line2> s/\(\s*\)#\(.*\)/\1\2/g
endfunction
autocmd BufEnter *.py,*.tw,*.cinc,*.cconf,*.thrift-cvalidator,*.ctest,TARGETS call DoPythonSettings()

" Highlight lines longer than 80 chars
autocmd! BufWinEnter *.php,*.cpp,*.c,*.h,*.java,*.lua,*.js,*.py,*.tw,*.conf,*.thrift,TARGETS let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Show whitespace at the end of lines, but not the current line when in insert mode
highlight ExtraWhitespace ctermbg=lightgrey guibg=lightgrey
autocmd ColorScheme * highlight ExtraWhitespace guibg=lightgrey
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

" Use templates when I have them
autocmd! BufNewFile * silent! 0r ~/.vim/tmpl/tmpl.%:e

" Open close folds with <space>
nnoremap <space> za
vnoremap <space> zf
set foldnestmax=4

" Save view (fold) settings on exit
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
set backspace=2

"If you are using flake8 and want to ignore certain errors, add them here
let g:flake8_ignore="E126,W404"

" Strip trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,pl,perl,siv,vim,go
  \ autocmd BufWritePre <buffer>
  \ :call <SID>StripTrailingWhitespaces()

" KILL WINDOWS ON CLOSE
" kill Nerdtree if only one open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" kill quickfix if only one open
aug QFClose
      au!
        au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

