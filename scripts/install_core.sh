#!/usr/bin/env bash

apt_packages=(
    # Essentials
    'git'
    'wget'
    'zsh'
)

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'

# Debian / Ubuntu system
# Install base packages in Advanced Packaging Tool
if [ -f "/etc/debian_version" ]; then
    # Print intro message
    echo -e "${PURPLE}Starting Debian/ Ubuntu package install & update script"
    echo -e "${RESET}"

    # Check apt-get actually installed
    if ! hash apt 2> /dev/null; then
        echo "${YELLOW}apt doesn't seem to be present on your system. Exiting...${RESET}"
        exit 1
    else
        echo -e "${YELLOW}apt is installed!"
        echo -e "${RESET}"
    fi    

    # update package database
    echo -e "${PURPLE}Updating database...${RESET}"
    sudo apt update

    # upgrade currently installed packages
    echo -e "${PURPLE}Upgrading installed packages...${RESET}"
    sudo apt upgrade

    # clear old package caches
    echo -e "${PURPLE}Freeing up disk space...${RESET}"
    sudo apt autoclean

    # install all listed packages
    echo -e "${PURPLE}Starting install...${RESET}"
    for package in ${apt_packages[@]}; do
        echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${package}...${RESET}"
        sudo apt install ${package} --assume-yes
    done
fi

echo -e "${PURPLE}Finished installing / updating Debian packages.${RESET}"