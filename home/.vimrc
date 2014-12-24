set nocompatible

" Required Vundle setup
filetype off

call plug#begin('~/.vim/plugged')

"Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'SirVer/ultisnips'
Plug 'bling/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'editorconfig/editorconfig-vim'
"Plug 'ervandew/supertab'
Plug 'fs111/pydoc.vim'
Plug 'godlygeek/tabular'
Plug 'henrik/vim-indexed-search'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'scottdware/vim-slax'
Plug 'scrooloose/syntastic'
Plug 'sickill/vim-monokai'
Plug 'sjl/gundo.vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/The-NERD-tree'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'Shougo/neocomplete.vim'

" SCM Plugins
"Plug 'motemen/git-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Languge specific Plugins
Plug 'fatih/vim-go'
Plug 'ClockworkNet/vim-junos-syntax'
Plug 'CyCoreSystems/vim-cisco-ios'

" Python
Plug 'tell-k/vim-autopep8'

" Colors
Plug 'MaxSt/FlatColor'
Plug 'altercation/vim-colors-solarized'

call plug#end()

" Facebook
if filereadable("/etc/fbwhoami")
    source $ADMIN_SCRIPTS/master.vimrc
endif

" ----------------
" .vimrc functions
" ----------------
let s:cache_dir = '~/.vim/.cache'
function! s:get_cache_dir(suffix)
  return resolve(expand(s:cache_dir . '/' . a:suffix))
endfunction

function! EnsureExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction



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
"colorscheme flatcolor
"let g:flatcolor_asphaltbg=0

set timeoutlen=300                                  "mapping timeout
set ttimeoutlen=50                                  "keycode timeout

set mouse=a                                         "enable mouse
set mousehide                                       "hide when characters are typed
set history=1000                                    "number of command lines to remember
set ttyfast                                         "assume fast terminal connection
set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility
set encoding=utf-8                                  "set encoding for text
if exists('$TMUX')
  set clipboard=
else
  set clipboard=unnamed                             "sync with OS clipboard
endif
set hidden                                          "allow buffer switching without saving
set autoread                                        "auto reload if file saved externally
set fileformats+=mac                                "add mac to auto-detection of file format line endings
set nrformats-=octal                                "always assume decimal numbers
set showcmd
set tags=tags;/
set showfulltag
set modeline
set modelines=5

" whitespace
set backspace=indent,eol,start                      "allow backspacing everything in insert mode
set autoindent                                      "automatically indent to match adjacent lines
set expandtab                                       "spaces instead of tabs
set smarttab                                        "use shiftwidth to enter tabs
set tabstop=4                                       "number of spaces per tab for display
set softtabstop=4                                   "number of spaces per tab in insert mode
set shiftwidth=4                                    "number of spaces when indenting
set list                                            "highlight whitespace
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
set shiftround
set linebreak
let &showbreak='↪ '

set scrolloff=1                                     "always show content after scroll
set scrolljump=5                                    "minimum number of lines to scroll
set display+=lastline
set wildmenu                                        "show list for autocomplete
set wildmode=list:full
set wildignorecase

set splitbelow
set splitright

" disable sounds
set noerrorbells
set novisualbell
set t_vb=

" searching
set hlsearch                                        "highlight searches
set incsearch                                       "incremental searching
set ignorecase                                      "ignore case for searching
set smartcase                                       "do case-sensitive if there's a capital letter
if executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

set showmatch                                       "automatically highlight matching braces/brackets/etc.
set matchtime=2                                     "tens of a second to show matching parentheses
set number
set lazyredraw
set laststatus=2
set noshowmode
set foldenable                                      "enable folds by default
set foldmethod=syntax                               "fold via syntax of files
set foldlevelstart=99                               "open all folds by default
let g:xml_syntax_folding=1                          "enable xml folding

" persistent undo
if exists('+undofile')
    set undofile
    let &undodir = s:get_cache_dir('undo')
endif

" backups
set backup
let &backupdir = s:get_cache_dir('backup')

" swap files
let &directory = s:get_cache_dir('swap')
set noswapfile

call EnsureExists(s:cache_dir)
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline_theme="powerlineish"
let g:airline#extensions#syntastic#enabled =  1


"  tpope/vim-unimpaired
nmap <c-up> [e
nmap <c-down> ]e
vmap <c-up> [egv
vmap <c-down> ]egv

"-----
" Keys
"-----

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
nnoremap <c-a> I
nnoremap <c-e> A

" Save some typing
nnoremap ; :

" (FUNCTION) <F1-12>commands"
nnoremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>:GitGutterToggle<CR>
set pastetoggle=<F2>
map <F5> :NERDTreeToggle<CR>
nnoremap <F6> :GundoToggle<CR>
nmap <F7> :TagbarToggle<CR>

" tpope/vim-fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
"autocmd BufReadPost fugitive://* set bufhidden=delete

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
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
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
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,pl,perl,siv,vim,go,slax
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

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

