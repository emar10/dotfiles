#!/bin/zsh
# Ethan's zsh config

if [ -d /usr/share/zsh/site-functions ]; then
    fpath=(/usr/share/zsh/site-functions $fpath)
fi

# Autoloads
autoload -Uz compinit
autoload -Uz promptinit; promptinit
autoload colors; colors
compinit

zle_highlight=(default:bold)

zstyle ':completion:*' menu select

HISTFILE=~/.zsh_history
SAVEHIST=100

setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt monitor

setopt COMPLETE_ALIASES

bindkey -v

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

export EDITOR=nvim
export VISUAL=nvim
 
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
