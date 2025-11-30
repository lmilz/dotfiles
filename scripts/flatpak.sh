#!/usr/bin/env bash

flatpak_packages=(
    "com.google.Chrome"
    "md.obsidian.Obsidian"
)

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'


echo -e "${PURPLE}Starting Flatpak package install script${RESET}"

# Check if flatpak is installed
if ! command -v flatpak &>/dev/null; then
    echo -e "${YELLOW}Flatpak is not installed on this system.${RESET}"
fi

echo -e "${YELLOW}Flatpak is installed!${RESET}"

# Add Flathub if missing
if ! flatpak remotes | grep -q "flathub"; then
    echo -e "${PURPLE}Adding Flathub repository...${RESET}"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi


echo -e "${PURPLE}Installing Flatpak packages...${RESET}"
for package in "${flatpak_packages[@]}"; do
    echo -e "${PURPLE}[Installing]${LIGHT} ${package}...${RESET}"
    flatpak install -y flathub "$package"
done

echo -e "${PURPLE}Flatpak installation complete.${RESET}"

