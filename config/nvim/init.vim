""" init.vim, Sasquatch flavored. Crunchy. ###

" Grab OS for platform-specific things
let g:os = substitute(system('echo $OSTYPE'), '\n', '', '')

" basic configuration
set nocompatible

" Little plugin manager will not push self!
packadd minpac
call minpac#init()

"" minpac will now push self
call minpac#add('k-takata/minpac', {'type': 'opt'})

"" other plugins go here formatted as above
"" e.g., minpac#add('githubuser/reponame')

