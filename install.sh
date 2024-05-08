#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "Installing prerequisites..." 
# Function to install packages based on the detected package manager
install_packages() {
    local package_manager=$1
    local packages=$2

    case "$package_manager" in
        apt)
            sudo apt update && sudo apt install -y $packages
            ;;
        pacman)
            sudo pacman -Syu --noconfirm $packages
            ;;
        *)
            echo "Unsupported package manager: $package_manager"
            exit 1
            ;;
    esac
}

# Detect the package manager and set variable
if [ -f /etc/debian_version ]; then
    package_manager="apt"
elif [ -f /etc/arch-release ]; then
    package_manager="pacman"
else
    echo "Unsupported distribution"
    exit 1
fi

# Define packages to install
packages="git vim tmux tar curl gcc ripgrep fd-find python3"

# Call installation function
install_packages $package_manager "$packages"

# Universal package section

# Latest Neovim version
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install node

# Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh


# Define the Git repository URL
REPO_URL="https://github.com/Elahi-cs/dotfiles.git"

# Define the target directory in the user's home
TARGET_DIR="$HOME"

# Clone the repository into a temporary directory
echo "Copying dotfiles..."
TEMP_DIR=$(mktemp -d)
git clone $REPO_URL $TEMP_DIR

# Verify successful cloning
if [ $? -eq 0 ]; then
    # Copy the contents of the repo to the target directory
    cp -r $TEMP_DIR/* $TARGET_DIR

    # Clean up the temporary directory
    rm -rf $TEMP_DIR

    echo "Repository contents copied to $TARGET_DIR successfully."
else
    echo "Failed to clone the repository."
    exit 1
fi

echo "Installation and configuration complete!"
