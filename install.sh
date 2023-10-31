#!/usr/bin/sh

packages="neovim kitty i3"

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

