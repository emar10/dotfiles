#!/bin/bash
# first sets up directories and plugin managers,
# then creates links for all filenames listed in manifest.txt to the home directory

# Vim dirs and Vim-Plug
if [ ! -e "${HOME}/.vim/autoload/plug.vim" ]; then
    echo "Vim-Plug not present, installing..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -e "${HOME}/.vim/backup" ]; then
    echo "Creating vim backup directory..."
    mkdir -p $HOME/.vim/backup
fi

if [ ! -e "${HOME}/.vim/undo" ]; then
    echo "Creating vim swap directory..."
    mkdir -p $HOME/.vim/undo
fi

if [ ! -e "${HOME}/.vim/swap" ]; then
    echo "Creating vim swap directory..."
    mkdir -p $HOME/.vim/swap
fi

# Nvim dirs and minpac
if [ ! -e "${HOME}/.config/nvim" ]; then
    echo "Creating nvim directory..."
    mkdir -p $HOME/.config/nvim
fi

if [ ! -e "${HOME}/.config/nvim/pack/minpac" ]; then
    echo "minpac not present, installing..."
    mkdir -p $HOME/.config/nvim/pack/minpac/opt
    git clone https://github.com/k-takata/minpac.git \
        $HOME/.config/nvim/pack/minpac/opt/minpac
fi

# Zgen for zsh
if [ ! -e "${HOME}/.zgen/zgen.zsh" ]; then
    echo "Zgen not present, cloning..."
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

echo "Symlinking all files from 'manifest.txt' to your home folder..."
# make sure that the manifest exists
if [ ! -e manifest.txt ]; then
    echo "manifest.txt not found. Aborting..."
    exit 1
fi

# symlink those files, yo
while read -u 3 f; do
    # make sure the source file exists
    if [ ! -e $f ]; then
        echo "'$f' not found. Continuing..."
        continue
    fi

    # make sure that target does not exist
    of="$HOME/.$f"
    if [ -f $of -o -h $of ]; then
        echo "Removing '$of'..."
        rm $of
    fi

    # create link
    echo "Creating link from './$f' to '$of'"
    ln -s `pwd`/$f $of
done 3<manifest.txt
