" Neovim configuration
" Date: 25 February 2022
" Author: Ethan Martin

" Plugins
"" Ensure vim-plug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(stdpath('data') . '/plugged')

"" Utilities
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'

"" LSP support
Plug 'neovim/nvim-lspconfig', { 'tag': '*' }

"" Colorschemes
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()


" General Settings
"" Soft tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"" Mouse support
set mouse=a

"" Colorscheme
set termguicolors
silent! colorscheme catppuccin
