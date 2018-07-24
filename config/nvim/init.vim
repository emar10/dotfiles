" init.vim, Sasquatch flavored. Crunchy.

""" Plugins
call plug#begin()
" let plug manage itself
Plug 'junegunn/vim-plug'

"" Colorschemes
Plug 'morhetz/gruvbox'

"" UI
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'

"" Language Support / Building
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

"" Misc Tools
Plug 'junegunn/vim-easy-align'
Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-fugitive'

call plug#end()

""" Options

set encoding=utf-8

set nowrap
set textwidth=0
set colorcolumn=80

set number
set cursorline
set noshowmode
set mouse=a

"" tabs as spaces or death
set smarttab
set expandtab
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

set lazyredraw
set backspace=indent,eol,start

set hidden

"" colors
set background=dark
colorscheme gruvbox

"" Terminal Settings
au! TermOpen * setlocal nonumber


""" Plugin settings

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"" Goyo / Limelight
function! s:goyo_enter()
    Limelight
    set wrap
endfunction

function! s:goyo_leave()
    set nowrap
    Limelight!
endfunction

au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()


""" Keybindings

"" Tagbar / Nerdtree
noremap <C-n> :NERDTreeToggle<CR>
noremap <C-m> :TagbarToggle<CR>

