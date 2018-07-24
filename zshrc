#!/bin/zsh
### Sasquatch's zshrc. Delicious

## inital setup stuff
# paths
export PATH=$HOME/bin:$PATH
fpath=(/usr/local/share/zsh-completions $HOME/.zsh/themes/ $fpath)

## zgen
source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
    ## plugins go here
    # terminal
    zgen load 'chrissicool/zsh-256color'

    # git
    zgen load 'peterhurford/git-it-on.zsh'

    # os-specific things
    if [[ $OSTYPE == darwin* ]]; then
        zgen load 'unixorn/tumult.plugin.zsh'
    fi

    # we done
    zgen save
fi

## built-in plugins
autoload -Uz promptinit; promptinit
autoload colors; colors

## theme
prompt sass
zle_highlight=(default:bold)

## completions
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

## assorted variables and sundries
# history
HISTFILE=~/.zsh_history
SAVEHIST=100

## i hope she made lotsa options
# shared and persistent history
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

# complete from aliases
setopt COMPLETE_ALIASES

## pretty colors
# ls
if [[ $OSTYPE == darwin* ]]; then
    export CLICOLOR=1
    export LSCOLORS=exfxcxdxbxegedabagacad
elif [[ $OSTYPE == linux* ]]; then
    alias ls='ls --color'
fi
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

## pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# vars
export EDITOR=nvim
export VISUAL=nvim


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
