HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/ethan/.zshrc'

autoload -Uz compinit
compinit

eval "$(sheldon source)"

autoload -Uz promptinit; promptinit
prompt pure
