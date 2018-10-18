#!/bin/bash
res=$(cat ~/.bashrc | grep "alias config")

if [ -z "$res" ]
then
    echo "dotfile setup..."

    echo ".cfg" >> .gitignore
    echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    
    git clone --bare git@github.com:davidbullado/dot.git $HOME/.cfg
    
    config checkout
    if [ $? = 0 ]; then
        echo "Checked out config.";
    else
        echo "Backing up pre-existing dot files.";
        mkdir -p .config-backup
        config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
        config checkout
    fi;
    config config --local status.showUntrackedFiles no

else
      echo "dotfile is already installed"
fi