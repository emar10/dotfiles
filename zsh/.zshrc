HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/ethan/.zshrc'

path+=$HOME/.cargo/bin
path+=$HOME/.local/bin
export PATH

eval "$(sheldon source)"

autoload -Uz compinit
compinit

autoload -Uz promptinit; promptinit
prompt pure
