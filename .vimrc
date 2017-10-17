""" .vimrc, Sasquatch flavored. Mmm.

" nobody wants to be in compatible mode
set nocompatible


"" BEGIN BUNDLING OUR VUNDLE ""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle should update Vundle
Plugin 'VundleVim/Vundle.vim'
" GitHub hosted plugin [plugin in subdirectory] [name conflict]
" Plugin 'account/reponame' [{'rtp': 'subdir/'}] [{'name': 'newname'}]
" other Git
" Plugin 'git://hostname/repo.git'

" local file
" Plugin 'file:///path/to/plugin'

Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'benmills/vimux'
Plugin 'majutsushi/tagbar'

Plugin 'Shougo/neocomplete.vim'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'davidhalter/jedi-vim'

"Plugin 'Townk/vim-autoclose'
Plugin 'tomtom/tcomment_vim'

"Plugin 'w0rp/ale'

Plugin 'airblade/vim-gitgutter'

Plugin 'vim-airline/vim-airline'
"Plugin 'itchyny/lightline.vim'

call vundle#end()
filetype plugin indent on
"" OUR VUNDLE IS DUNDLE, WE'RE READY TO RUNDLE ""
"" Quick Vundle Cheatsheet from the GitHub repo""
" :PluginInstall    - installs plugins
" :PluginUpdate     - fetches updates for plugins
" :PluginList       - shows active plugins
" :PluginClean      - gets rid of unused plugins


"" config
" pretty colors
syntax on

" wrapping is for chumps
set nowrap
set encoding=utf8

" line numbers are pretty sweet
set number
set ruler

set laststatus=2
set cursorline

" clickety click, scrolling is cool too
set mouse=a

" gib gud tabs pl0x
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent

" Let's try to get rid of that annoying delay with escape
set timeoutlen=1000
set ttimeoutlen=10

" Macs have some funkiness with backspace, lemme fix that for ya
set backspace=indent,eol,start

" Omni
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" 2 spaces for HTML/CSS
autocmd FileType html,css set tabstop=2 shiftwidth=2

"" Plugin Options
" Airline
let g:airline_highlighting_cache = 1

" Neocomplete
let g:neocomplete#data_directory='~/.cache/neocomplete'
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#syntax#min#keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

let g:neocomplete#enable_auto_select = 0

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.java = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns = {}

"" Keybindings
" NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-M> :TagbarToggle<CR>

" Neocomplete
" Omnicomplete Better Nav
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

