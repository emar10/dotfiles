" Ethan's nvim config

" Plugins (via vim-plug)
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'

"" Language Support
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

"" Colorschemes
Plug 'arcticicestudio/nord-vim'

"" Filesystem / Version Control
Plug 'justinmk/vim-dirvish'
Plug 'itchyny/lightline.vim'

"" Editing
Plug 'junegunn/vim-easy-align'
call plug#end()


" Settings
set encoding=utf-8

set nowrap
set colorcolumn=80

set number
set cursorline
set noshowmode
set laststatus=2
set mouse=a

set smarttab
set expandtab
set autoindent
set shiftwidth=4
au! FileType html,css setlocal sw=2

set wildmenu
set wildmode=full

set hidden
set directory=~/.local/share/nvim/swap//
set backupdir=~/.local/share/nvim/backup//
set undodir=~/.local/share/nvim/undo//

set background=dark
silent! colorscheme nord


" Plugin Settings
"" Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'nord'
