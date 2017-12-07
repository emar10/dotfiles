""" .vimrc, Sasquatch flavored. Mmm.

"" config
" nobody wants to be in compatible mode
set nocompatible

" what OS are we on?
let g:os = substitute(system('echo $OSTYPE'), '\n', '', '')

" use python3
set pyxversion=3

" pretty colors
syntax on

" wrapping is for chumps
set nowrap
set encoding=utf-8

" line numbers are pretty sweet
set number
set ruler

set laststatus=2
set cursorline

" scrolling is cool too
set mouse=a
set scrolljump=5
set scrolloff=3

" automagical folding
"set foldenable

" gib gud tabs pl0x
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
filetype indent plugin on

" escape sequence length
set timeoutlen=1000
set ttimeoutlen=10

" Macs have some funkiness with backspace, lemme fix that for ya
set backspace=indent,eol,start

" Keep buffers around
set hidden

" 2 spaces for HTML/CSS
autocmd FileType html,css set tabstop=2 shiftwidth=2


"" LET'S PLUG SOME PLUGINS, KIDDOS ""
call plug#begin('~/.vim/plugged')
" Plug 'account/reponame' [{'rtp': 'subdir/'}] [{'as': 'newname'}]

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
"Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

" Completion and Linting
"Plug 'ajh17/VimCompletesMe'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/deoplete.nvim'
Plug 'w0rp/ale'

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'fidian/hexmode'

" Language Support
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'Shougo/neoinclude.vim'
Plug 'artur-shaik/vim-javacomplete2'

call plug#end()
"" PLUGS ARE PLUGGED, WE'RE READY TO PLARTY ""
" :PlugInstall    - installs plugins
" :PlugUpdate     - fetches updates for plugins
" :PlugClean      - gets rid of unused plugins
" :PlugUpgrade    - upgrade vim-plug
" :PlugStatus     - check plugin status


"" Plugin Options
" Airline
let g:airline_highlighting_cache = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#ignore_sources = {}

" Clang
if g:os =~ "darwin.*"
    let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'
    let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/5.0.0/lib/clang/5.0.0/include/'
endif

" Javacomplete2
"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"let g:deoplete#omni#input_patterns.java = [
"    \'[^. \t0-9]\.\w*',
"    \'[^. \t0-9]\->\w*',
"    \'[^. \t0-9]\::\w*',
"    \]
"let g:deoplete#omni#input_patterns.jsp = ['[^. \t0-9]\.\w*']
"let g:deoplete#ignore_sources._ = ['javacomplete2']

"" Keybindings
" NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-M> :TagbarToggle<CR>

