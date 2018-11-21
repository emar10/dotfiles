#!/bin/bash
# first sets up directories and plugin managers,
# then creates links for all filenames listed in manifest.txt to the home directory

# Nvim dirs and vim-plug
if [ ! -e "${HOME}/.config/nvim" ]; then
    echo "Creating nvim directory..."
    mkdir -p $HOME/.config/nvim
fi

if [ ! -e "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo "vim-plug not present, installing..."
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# zplug for zsh
if [ ! -e "${HOME}/.zplug/init.zsh" ]; then
    echo "zplug not present, installing..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
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
