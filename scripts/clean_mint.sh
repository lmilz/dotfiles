#!/bin/bash

# List of programs to remove
PROGRAMS=(
    "firefox"
    "thunderbird"
    "libreoffice*"
    "hexchat"
    "rhythmbox"
    "pidgin"
)

echo "=== Linux Mint Software Remover ==="
echo "The following programs can be uninstalled:"
printf '%s\n' "${PROGRAMS[@]}"
echo

# Ask for confirmation
read -p "Do you want to continue? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Cancelled."
    exit 0
fi

echo
echo "Starting uninstallation..."
echo

# Remove the programs
for pkg in "${PROGRAMS[@]}"; do
    echo "→ Removing: $pkg"
    sudo apt-get remove --purge -y $pkg
done

echo
echo "→ Cleaning up unused packages..."
sudo apt autoremove -y
sudo apt autoclean -y

echo
echo "Done! The selected software has been removed."