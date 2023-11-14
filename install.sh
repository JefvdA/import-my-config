#!/usr/bin/sh

packages="neovim kitty i3"

echo "\033[0;31mInstalling packages...\033[0m"

for package in $packages; do
    # Use apt to install the package
    sudo apt install -y "$package"

    # Check the exit status of the installation
    if [ $? -eq 0 ]; then
        echo "\033[0;31mSuccessfully installed $package!\033[0m"
    else
        echo "\033[0;31mFailed to install $package!\033[0m"
    fi
done

echo "\033[0;31mInstalling vim-plug...\033[0m" 
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "\033[0;31m'vim-plug' is successfully installed!" 

echo "\033[0;31mInstalling vim plugins...\033[0m"
nvim +PlugInstall +qall +silent
echo "\033[0;31mAll vim plugins successfully installed!\033[0m"

echo "\033[0;31mAll packages installed!\033[0m"

git config --global core.editor "nvim"
echo "\033[0;31mVim has been set as the default text editor for GIT!\033[0m"

KITTY_CONFIG_DIR=$HOME/.config/kitty

if [ -z "$(ls -A $KITTY_CONFIG_DIR)" ]; then
	git clone git@github.com:JefvdA/kitty-config.git $KITTY_CONFIG_DIR
	echo "\033[0;31mThe kitty config is cloned!\033[0m"
else
   echo "\033[0;31mThere was already configuration for kitty found - keeping existing config!\033[0m"
fi

NVIM_CONFIG_DIR=$HOME/.config/nvim

if [ -z "$(ls -A $NVIM_CONFIG_DIR)" ]; then
	git clone git@github.com:JefvdA/nvim-config.git $NVIM_CONFIG_DIR
	echo "\033[0;31The nvim config is cloned!\033[0m"
else
	echo "\033[0;31There was already configuration for nvim found - keeping existing config!\033[0m"
fi

I3_CONFIG_DIR=$HOME/.config/i3

sudo git clone https://github.com/JefvdA/i3wm-config.git $I3_CONFIG_DIR
echo "\033[0;31mThe i3 config is cloned!\033[0m"

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
