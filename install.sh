#!/bin/bash
# creates links for all filenames listed in manifest.txt to the home directory

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
