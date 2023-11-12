#!/usr/bin/sh

packages="neovim kitty i3"

echo "\033[0;31mInstalling packages...\033[0m"

for package in $packages; do
    # Use apt to install the package
    sudo apt install -y "$package"

    # Check the exit status of the installation
    if [ $? -eq 0 ]; then
        echo "Successfully installed $package"
    else
        echo "Failed to install $package"
    fi
done

echo "\033[0;31mAll packages installed!\033[0m"

BASH_ALIASES_DIR=$HOME/.bash-aliases

if [ ! -d $BASH_ALIASES_DIR ]
then
    echo "\033[0;31mInstalling bash aliases...\033[0m"
    git clone git@github.com:JefvdA/bash-aliases.git $BASH_ALIASES_DIR
    echo "# Add bash aliases from my config - JefvdA\nsource $BASH_ALIASES_DIR/aliases.sh\n" >> $HOME/.bashrc
    echo "\033[0;31mThe bash aliases are cloned & are imported in your .bashrc !\033[0m"
else
    echo "\033[0;31mThe bash aliases were already cloned - Skipped this\033[0m"
fi
