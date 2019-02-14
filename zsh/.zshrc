#!/bin/zsh
### Sasquatch's zshrc. Delicious

## inital setup stuff
# paths
export PATH=$HOME/bin:$PATH
fpath=(/usr/local/share/zsh-completions $HOME/.zsh/themes/ $fpath)

## zplug
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme

# let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [Y/n] "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

## built-in plugins
autoload -Uz promptinit; promptinit
autoload colors; colors

## theme
zle_highlight=(default:bold)

## completions
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
setopt monitor

# complete from aliases
setopt COMPLETE_ALIASES

# real champs use vi mode
bindkey -v

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

# vars
export EDITOR=nvim
export VISUAL=nvim

