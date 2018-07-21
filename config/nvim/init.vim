""" init.vim, Sasquatch flavored. Crunchy. ###


" Grab OS for platform-specific things
let g:os = substitute(system('echo $OSTYPE'), '\n', '', '')


" basic configuration
set nocompatible

set nowrap
set textwidth=0
if exists('&colorcolumn')
    set colorcolumn=80
endif
set encoding=utf-8

set number
set ruler

set cursorline

"" So I like having mouse support, what of it?
set mouse=a

"" tabs as spaces or death
set smarttab
set expandtab
set autoindent
set tabstop=4
set shiftwidth=4
filetype indent plugin on

""" 2 space tab for web stuff because W3 says so
autocmd Filetype html,css,scss setlocal ts=2 sw=2

"" Hidden buffers are cool
set hidden

"" Terminal mode settings
autocmd TermOpen * setlocal nonumber norelativenumber noruler nocursorline

" Little plugin manager will not push self! "
packadd minpac
call minpac#init()

"" minpac will now push self
call minpac#add('k-takata/minpac', {'type': 'opt'})

"" other plugins go here formatted as above
"" e.g., call minpac#add('githubuser/reponame')

""" Pretty Colors
call minpac#add('ajmwagar/vim-deus')
call minpac#add('nightsense/vimspectr')

""" UI
call minpac#add('scrooloose/nerdtree')
call minpac#add('majutsushi/tagbar')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')

call minpac#add('tpope/vim-obsession')
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/limelight.vim')

""" Completion Engine
"call minpac#add('roxma/nvim-completion-manager')  " ncm is unmaintained :(
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('autozimu/LanguageClient-neovim')

""" Building
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')

call minpac#add('tfnico/vim-gradle')

""" FZF
call minpac#add('junegunn/fzf.vim')
set rtp+=/usr/local/opt/fzf


" Plugin settings

"" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"" NERDTree
map <C-n> :NERDTreeToggle<CR>

"" TagBar
map <C-m> :TagbarToggle<CR>

"" Deoplete
let g:deoplete#enable_at_startup = 1

"" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'java': ['jdtls', '-Dlog.level=ALL'],
    \ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/Users/ethan/.config/nvim/settings.json'

"" Goyo
function! s:goyo_enter()
    set noshowmode
    set wrap
    set linebreak
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set nowrap
    set linebreak
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Vimr specific things
if has('gui_vimr')
    "" Colors
    colorscheme deus
    set background=dark
    let g:airline_theme = 'deus'
    let g:terminal_color_0 = '#2C323B'
    let g:terminal_color_1 = '#fb4934'
    let g:terminal_color_2 = '#98C379'
    let g:terminal_color_3 = '#fabd2f'
    let g:terminal_color_4 = '#83a598'
    let g:terminal_color_5 = '#C678DD'
    let g:terminal_color_6 = '#8ec07c'
    let g:terminal_color_7 = '#fe8019'
    let g:terminal_color_8 = '#6c7c93'
    let g:terminal_color_9 = '#fc7869'
    let g:terminal_color_10 = '#bbd7a7'
    let g:terminal_color_11 = '#fbd06a'
    let g:terminal_color_12 = '#b5c9c2'
    let g:terminal_color_13 = '#dcadeb'
    let g:terminal_color_14 = '#b5d6a9'
    let g:terminal_color_15 = '#feab67'
endif

