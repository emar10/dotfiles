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
Plugin 'tomtom/tcomment_vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'vim-airline/vim-airline'

Plugin 'fidian/hexmode'

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

" 2 spaces for HTML/CSS
autocmd FileType html,css set tabstop=2 shiftwidth=2

"" Plugin Options
" Airline
let g:airline_highlighting_cache = 1

"" Keybindings
" NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-M> :TagbarToggle<CR>

