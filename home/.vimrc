" Must be disabled before loading pathogen
filetype off

" pathogen to autoload bundles
let g:pathogen_disabled = [ 'pathogen' ]    " don't load self
call pathogen#infect()                      " load everyhting else
call pathogen#helptags()                    " load plugin help files

" re-enable syntax/filetype
syntax on
filetype plugin indent on

" Facebook
if filereadable("/etc/fbwhoami")
    source $ADMIN_SCRIPTS/master.vimrc
endif

" syntax highlighting
syntax on
filetype on                 " enables filetype detection
filetype plugin indent on   " enables filetype specific plugins

"Colors
set t_Co=256
set background=dark
"colorscheme monokai
let g:solarized_termcolors=256
colorscheme solarized

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
set statusline=%{GitBranch()}

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

" Golang
au BufRead,BufNewFile *.go set filetype=go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

