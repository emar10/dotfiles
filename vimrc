""" .vimrc, Sasquatch flavored. Mmm.

" nobody wants to be in compatible mode
set nocompatible

" what OS are we on?
let g:os = substitute(system('echo $OSTYPE'), '\n', '', '')

" use python3
set pyxversion=3

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
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'jiangmiao/auto-pairs'

" Completion and Linting
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'Shougo/deoplete.nvim'
Plugin 'w0rp/ale'

Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'fidian/hexmode'

" Language Support
Plugin 'zchee/deoplete-jedi'
Plugin 'zchee/deoplete-clang'
Plugin 'Shougo/neoinclude.vim'
Plugin 'artur-shaik/vim-javacomplete2'

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
set foldenable

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

" Keep buffers around
set hidden

" 2 spaces for HTML/CSS
autocmd FileType html,css set tabstop=2 shiftwidth=2

"" Plugin Options
" Airline
let g:airline_highlighting_cache = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns',{})
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

