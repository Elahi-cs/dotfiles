#!/bin/bash
set -euo pipefail

# Bootstrap a new machine with these dotfiles + the tools they depend on.
#
# Run as your normal user (NOT root). Package installs use sudo internally;
# everything else (oh-my-zsh, nvm, rust, zoxide, dotfiles) is installed into
# your own $HOME, which is why this must not run as root.
if [[ $EUID -eq 0 ]]; then
    echo "Do not run as root. Run as your normal user; sudo is used where needed." >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Decision point: should this bootstrap make zsh your default login shell?
# true  -> runs chsh so new logins start in zsh (convenient on your own box)
# false -> leaves your current login shell untouched (safer on shared/remote
#          boxes where a misconfigured zsh could lock you out)
# ---------------------------------------------------------------------------
CHANGE_SHELL=true

# --- System packages -------------------------------------------------------
echo "Installing prerequisites..."
install_packages() {
    local pm=$1 pkgs=$2
    case "$pm" in
        apt)    sudo apt update && sudo apt install -y $pkgs ;;
        pacman) sudo pacman -Syu --noconfirm $pkgs ;;
        *)      echo "Unsupported package manager: $pm" >&2; exit 1 ;;
    esac
}

if [ -f /etc/debian_version ]; then
    package_manager="apt"
    # urlview (tmux 'u' binding), xclip ('copy' alias), zsh, go, build tools
    packages="git vim tmux zsh tar curl gcc ripgrep fd-find python3 golang-go fzf xclip urlview"
elif [ -f /etc/arch-release ]; then
    package_manager="pacman"
    packages="git vim tmux zsh tar curl gcc ripgrep fd python3 go fzf xclip urlview"
else
    echo "Unsupported distribution" >&2
    exit 1
fi

install_packages "$package_manager" "$packages"

# --- Latest Neovim (matches the /opt/nvim-linux-x86_64/bin PATH in .zshrc) --
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm -f nvim-linux-x86_64.tar.gz

# --- oh-my-zsh (.zshrc sources $ZSH/oh-my-zsh.sh) --------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    # --unattended: don't run zsh or chsh from the installer; we handle the
    # shell switch ourselves below based on CHANGE_SHELL.
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Rust / cargo (.zshenv sources $HOME/.cargo/env) -----------------------
if [ ! -d "$HOME/.cargo" ]; then
    echo "Installing Rust toolchain..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# --- Node Version Manager --------------------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm + node..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install node
fi

# --- Zoxide ----------------------------------------------------------------
if ! command -v zoxide >/dev/null 2>&1; then
    echo "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# --- Copy the dotfiles into $HOME ------------------------------------------
# Copy from the directory this script lives in, so it works whether you
# cloned the repo or are running it in place. Explicit file list avoids the
# `cp *` dotfile-glob trap and never touches .git / install.sh.
echo "Copying dotfiles..."
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SRC_DIR/.zshrc"   "$HOME/.zshrc"
cp "$SRC_DIR/.zshenv"  "$HOME/.zshenv"
cp "$SRC_DIR/.tmux.conf" "$HOME/.tmux.conf"
if [ -d "$SRC_DIR/.config" ]; then
    mkdir -p "$HOME/.config"
    cp -r "$SRC_DIR/.config/." "$HOME/.config/"
fi

# --- Optionally make zsh the default login shell ---------------------------
if [ "$CHANGE_SHELL" = true ] && [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Setting zsh as the default login shell..."
    chsh -s "$(command -v zsh)"
fi

echo "Installation and configuration complete! Start a new shell (or run: exec zsh)."
