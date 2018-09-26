" init.vim, Sasquatch flavored. Crunchy.

""" Plugins
call plug#begin()
"" let plug manage itself
Plug 'junegunn/vim-plug'

"" Colorschemes
Plug 'morhetz/gruvbox'
"Plug 'shinchu/lightline-gruvbox.vim'

"" UI
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
"Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'

"" Language Support / Building
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'igankevich/mesonic'

"" Misc Tools
Plug 'junegunn/vim-easy-align'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

""" Options

set encoding=utf-8

set nowrap
"set textwidth=0
"set colorcolumn=80

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
au! FileType html,css,python setlocal sw=2 ts=2

"set lazyredraw
set backspace=indent,eol,start

set wildmenu
set wildmode=full

set hidden

"" colors
set termguicolors
set background=dark
colorscheme gruvbox

"" Terminal Settings
au! TermOpen * setlocal nonumber nocursorline


""" Plugin settings

"" netrw / vim-vinegar
let g:netrw_liststyle = 3
"let g:netrw_banner = 0
"let g:netrw_browse_split = 1
"let g:netrw_winsize = 25

"" Airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1

"" Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
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
let g:lightline.active = {
    \ 'left': [ [ 'mode' ],
    \           [ 'gitbranch', 'githunk' ],
    \           [ 'filename', 'readmodified' ] ],
    \ 'right': [ ['lineinfo', 'linepercent'],
    \            ['filetype'] ]
    \ }

" Git hunks
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

" Readonly
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

"" Startify
let g:startify_session_dir = '~/.local/share/nvim/sessions'
let g:startify_session_persistence = 1
let g:startify_change_to_session_root = 1
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['    Sessions']  },
    \ { 'type': 'bookmarks', 'header': ['    Bookmarks'] },
    \ { 'type': 'files',     'header': ['    Recents']   }
    \ ]
let s:startify_ascii_header = [
    \ '                                        ▟▙            ',
    \ '                                        ▝▘            ',
    \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
    \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
    \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
    \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
    \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
    \ '',
    \ ]
let g:startify_custom_header = map(s:startify_ascii_header +
            \ startify#fortune#quote(), '"   ".v:val')

""" Function Fun Fest
function! s:lightline_reload()
    " Try to reload colorscheme
    execute "runtime autoload/lightline/colorscheme/" . g:lightline.colorscheme . ".vim"
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
command! LightlineReload call <SID>lightline_reload()


""" Keybindings

"" Insert mode
" no carpal tunnel pls
inoremap jk <esc>

