fpath=(/usr/local/share/zsh-completions $fpath)
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PROMPT='[%n@%m:%~]%# '
