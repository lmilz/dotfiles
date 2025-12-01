#!/usr/bin/env bash

pacman_packages=(
    # Essentials
    'git'
    'wget'
    'curl'
    'btop'
    'alacritty'
    'zsh'
    'htop'
    'neovim'

    # Core dev tools (base-devel is required for building AUR)
    'base-devel'
    'cmake'
    'gdb'
    'clang'
    'clang-tools-extra'   # contains clang-format
    'python'              # python3
    'python-pip'
    'python-virtualenv'
    'ruby'                # ruby-full
    'nodejs'
    'npm'
    'go'

    # Fonts
    'ttf-jetbrains-mono'
)

aur_packages=(
    # AUR fonts or tools if needed
    # (leer lassen oder ergänzen)
)

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'

# Arch / EndeavourOS detection
if [[ -f "/etc/arch-release" ]]; then
    echo -e "${PURPLE}Starting Arch / EndeavourOS package install & update script${RESET}"

    if ! hash pacman 2>/dev/null; then
        echo -e "${YELLOW}pacman not found! Exiting...${RESET}"
        exit 1
    fi

    echo -e "${YELLOW}pacman found!${RESET}"

    echo -e "${PURPLE}Updating system...${RESET}"
    sudo pacman -Syu --noconfirm

    echo -e "${PURPLE}Installing pacman packages...${RESET}"
    for package in "${pacman_packages[@]}"; do
        echo -e "${PURPLE}[Installing]${LIGHT} ${package}...${RESET}"
        sudo pacman -S --needed --noconfirm "$package"
    done

    # Install yay if missing
    if ! hash yay 2>/dev/null; then
        echo -e "${YELLOW}yay not found — installing yay (AUR helper)...${RESET}"
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        cd /tmp/yay-bin
        makepkg -si --noconfirm
        cd -
    fi

    echo -e "${PURPLE}Installing AUR packages...${RESET}"
    for package in "${aur_packages[@]}"; do
        echo -e "${PURPLE}[AUR Installing]${LIGHT} ${package}...${RESET}"
        yay -S --needed --noconfirm "$package"
    done

    echo -e "${PURPLE}Configuration of zsh...${RESET}"
    # Change default shell to Zsh
    if [[ "$SHELL" != "/usr/bin/zsh" && "$SHELL" != "/bin/zsh" ]]; then
    	echo -e "${PURPLE}Setting Zsh as the default shell...${RESET}"
    	chsh -s "$(command -v zsh)"
    fi
    # Install Oh-My-Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    	echo -e "${PURPLE}Installing Oh-My-Zsh (non-interactive)...${RESET}"
    	RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi   
    
    # zsh Plugins
    # zsh-autosuggestion
    if [[ ! -d "$ZSH_CUSTOM/custom/plugins/zsh-autosuggestion" ]]; then
    	git clone https://github.com/zsh-users/zsh-autosuggestion.git $ZSH_CUSTOM/plugins/zsh-autosuggestion
    fi

    # zsh-syntax-hightlingt
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-hightlingt" ]]; then
    	git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-hightlingt"
    fi

    # Rust
    echo -e "${PURPLE}Installing Rust (rustup)...${RESET}"

    if ! command -v rustup &>/dev/null; then
    	echo -e "${PURPLE}Installing Rust via rustup...${RESET}"
    	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
    	export PATH="$HOME/.cargo/bin:$PATH"
    else
    	echo -e "${YELLOW}Rustup already installed. Updating...${RESET}"
    	rustup update
    fi

    rustup install stable
    rustup default stable


    echo -e "${PURPLE}Installation complete.${RESET}"
fi

echo -e "${PURPLE}Finished installing / updating Arch packages.${RESET}"
