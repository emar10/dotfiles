" Ethan's nvim config

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'

"" Tools
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

"" Language support
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

"" UI
Plug 'morhetz/gruvbox'
Plug 'justinmk/vim-dirvish'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'itchyny/lightline.vim'

"" Bridges
Plug 'maximbaz/lightline-ale'

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
set smartindent
set tabstop=4
set shiftwidth=4
au! FileType html,css setlocal sw=2 ts=2
au! FileType nasm,asm setlocal noexpandtab sw=0 ts=8

set backspace=indent,eol,start

set wildmenu
set wildmode=full

set hidden
set directory=~/.local/share/neovim/swap//
set backupdir=~/.local/share/neovim/backup//
set undodir=~/.local/share/neovim/undo//

set background=dark
colorscheme gruvbox
set termguicolors
let g:terminal_ansi_colors = [
            \ '#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286',
            \ '#689d6a', '#bdae93', '#7c6f64', '#fb4934', '#b8bb26', '#fabd2f',
            \ '#83a598', '#d3869b', '#8ec07c', '#ebdbb2']

"" Ensure that vimtex loads properly
let g:tex_flavor = 'tex'

"" Explicitly set python location
"if !empty($VIRTUAL_ENV)
"    let g:python3_host_prog = '$VIRTUAL_ENV/bin/python3'
"endif
let g:python3_host_prog = '/usr/bin/python3'


" ALE
let g:ale_linters = {
\ 'python': ['pyls'],
\ 'c': ['clangd'],
\}

let g:ale_linters_explicit = 1
let g:ale_python_auto_pipenv = 1


" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
            \ '_': ['ale']
            \})


" Startify
let g:startify_session_persistence = 1
let g:startify_change_to_session_root = 1
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['    Sessions']  },
    \ { 'type': 'bookmarks', 'header': ['    Bookmarks'] },
    \ { 'type': 'files',     'header': ['    Recents']   }
    \ ]


" Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
"let g:lightline.separator = { 'left': '', 'right': '' }
"let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.component = {
    \ 'lineinfo': ' %l/%L : %2v',
    \ 'linepercent': '%P',
    \ 'close': "%999X \uf00d ",
    \ 'gitbranch': '%{fugitive#head() == "" ? "" : " ".fugitive#head() }'
    \ }
let g:lightline.component_function = {
    \ 'githunk': 'LightlineHunk',
    \ 'readmodified': 'LightlineReadmodified'
    \ }
let g:lightline.component_expand = {
    \ 'linter_checking': 'lightline#ale#checking',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_ok': 'lightline#ale#ok',
    \ }
let g:lightline.component_type = {
    \ 'linter_checking': 'left',
    \ 'linter_warnings': 'warning',
    \ 'linter_errors': 'error',
    \ 'linter_ok': 'left',
    \ }
let g:lightline.active = {
    \ 'left': [ [ 'mode' ],
    \           [ 'gitbranch', 'githunk' ],
    \           [ 'filename', 'readmodified' ] ],
    \ 'right': [ ['linter_checking', 'linter_errors', 'linter_warnings'],
    \            ['lineinfo', 'linepercent'],
    \            ['filetype'] ]
    \ }
let g:lightline#ale#indicator_checking = ' '
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors   = ' '

"" Git hunks
function! LightlineHunk()
    if empty(fugitive#head())
        return ''
    endif
    let l:symbols = ['+','~','-']
    let l:stats = sy#repo#get_stats()
    let l:hunkline = ''

    for i in range(3)
        if stats[i] > 0
            let l:hunkline .= l:stats[i] . l:symbols[i] . ' '
        endif
    endfor
    if !empty(l:hunkline)
        let l:hunkline = strpart(l:hunkline, 0, strlen(l:hunkline) - 1)
    endif

    return l:hunkline
endfunction

"" Readonly
function! LightlineReadmodified()
    if &modified && !&readonly
        return ""
    elseif !&modified && !&readonly
        return ''
    elseif !&modified && &readonly
        return ""
    else  " modified and readonly
        return "﫺"
    endif
endfunction

if exists('g:gnvim')
    source ~/.config/nvim/ginit.vim
endif

