#!/usr/bin/env bash

apt_packages=(
    # Essentials
    'git'
    'wget'
    'curl'
    'btop'
    'zsh'

    # Development Basics
    'build-essential'
    'cmake'
    'clang'
    'g++'

    # Editors
    'neovim'

    # Python
    'python3'
    'python3-pip'
    'python3-venv'

    # Ruby
    'ruby-full'
)

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'

# Debian / Ubuntu system
if [ -f "/etc/debian_version" ]; then
    echo -e "${PURPLE}Starting Debian/Ubuntu package install & update script${RESET}"

    if ! hash apt 2> /dev/null; then
        echo "${YELLOW}apt does not seem to be present. Exiting...${RESET}"
        exit 1
    else
        echo -e "${YELLOW}apt is installed!${RESET}"
    fi    

    echo -e "${PURPLE}Updating database...${RESET}"
    sudo apt update

    echo -e "${PURPLE}Upgrading installed packages...${RESET}"
    sudo apt upgrade -y

    echo -e "${PURPLE}Freeing up disk space...${RESET}"
    sudo apt autoclean

    echo -e "${PURPLE}Installing packages...${RESET}"
    for package in ${apt_packages[@]}; do
        echo -e "${PURPLE}[Installing]${LIGHT} ${package}...${RESET}"
        sudo apt install -y --no-install-recommends ${package}
    done

    echo -e "${PURPLE}Installing Rust (rustup minimal)...${RESET}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

    # Add Rust to PATH for current session
    export PATH="$HOME/.cargo/bin:$PATH"

    echo -e "${PURPLE}Installing Jekyll + Bundler...${RESET}"
    gem install --no-document jekyll bundler
fi

echo -e "${PURPLE}Finished installing / updating Debian packages.${RESET}"
