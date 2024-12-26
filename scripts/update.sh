#!/bin/bash

# update system
echo "Update system..."
sudo apt update && sudo apt upgrade -y

# clean up
echo "Clean up system..."
sudo apt autoremove -y && sudo apt autoclean