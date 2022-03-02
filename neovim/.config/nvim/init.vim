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

"" Libs
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'

"" Utilities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'nvim-telescope/telescope.nvim'

"" UI
Plug 'lewis6991/gitsigns.nvim'
Plug 'feline-nvim/feline.nvim'
Plug 'Pocco81/TrueZen.nvim'

"" Language support
Plug 'neovim/nvim-lspconfig', { 'tag': '*' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"" Colorschemes
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()


" General Settings
"" Soft tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

"" Mouse support
set mouse=a

"" Colorscheme
set termguicolors
silent! colorscheme catppuccin

"" Misc
set nowrap
set noshowmode
set number
set cursorline
set wildmode


" Plugin Settings
"" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",

    highlight = {
        enable = true
    }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"" Others
lua << EOF
require'gitsigns'.setup()
require'feline'.setup({
    components = require('catppuccin.core.integrations.feline'),
})
EOF


" Mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

