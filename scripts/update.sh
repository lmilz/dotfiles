#!/bin/bash

# update system apt
echo "Update system..."
sudo apt update && sudo apt upgrade -y

# clean up apt
echo "Clean up system..."
sudo apt autoremove -y && sudo apt autoclean

# update configs
REPO_DIR="$HOME/Projekte/dotfiles/configs" # repo
TARGER_DIR="$HOME"

sync_files() {
    echo "update config files..."
    # zsh
    echo "zsh..."
    ZSH_SOURCE="$REPO_DIR/zsh/.zshrc"
    ZSH_TARGET="$HOME/.zshrc"
    cp -r "$ZSH_SOURCE" "$ZSH_TARGET"

    # i3
    echo "i3wm..."
    WM_SOURCE="$REPO_DIR/i3/config"
    WM_TARGET="$HOME/.config/i3/config"
    cp -r "$WM_SOURCE" "$WM_TARGET"
}

sync_files