#!/usr/bin/env bash

apt_packages=(
    # Essentials
    'git'
    'wget'
    'curl'
    'btop'
    'zsh'
    'tmux'
    'htop'
    'software-properties-common'

    # Core dev tools
    'build-essential'
    'cmake'
    'make'
    'automake'
    'autoconf'
    'pkg-config'
    'gdb'
    'clang'
    'clang-format'
    'g++'
    'valgrind'

    # Editor / Tools
    'neovim'
    'nano'
    'fzf'
    'ripgrep'
    'fd-find'

    # Python full
    'python3'
    'python3-pip'
    'python3-venv'
    'python3-dev'

    # Ruby
    'ruby-full'
    'zlib1g-dev'

    # System libs
    'lsb-release'
    'unzip'
    'ca-certificates'

    # Networking tools
    'net-tools'
    'dnsutils'
    'iputils-ping'

    # Fonts
    fonts-jetbrains-mono
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

    echo -e "${PURPLE}Cleaning up...${RESET}"
    sudo apt autoremove -y
    sudo apt autoclean

    echo -e "${PURPLE}Installing full development environment...${RESET}"
    for package in ${apt_packages[@]}; do
        echo -e "${PURPLE}[Installing]${LIGHT} ${package}...${RESET}"
        sudo apt install -y ${package}
    done

    echo -e "${PURPLE}Installing Rust (default profile)...${RESET}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

    export PATH="$HOME/.cargo/bin:$PATH"

    echo -e "${PURPLE}Installing Jekyll + Bundler...${RESET}"
    gem install --no-document jekyll bundler

    echo -e "${PURPLE}Installing Node.js (for Jekyll, Neovim plugins, JS tooling)...${RESET}"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs

    echo -e "${PURPLE}Installing common Node dev tools (npm, yarn, pnpm)...${RESET}"
    sudo npm install -g yarn
    sudo npm install -g pnpm

    echo -e "${PURPLE}Development environment installation complete.${RESET}"
fi

echo -e "${PURPLE}Finished installing / updating Debian packages.${RESET}"
