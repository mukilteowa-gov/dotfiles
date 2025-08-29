#!/bin/bash

# Dotfiles installation script using GNU Stow
# This script sets up symlinks for all dotfiles configurations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if stow is installed
check_stow() {
    if ! command -v stow &> /dev/null; then
        print_error "GNU Stow is not installed!"
        print_status "Please install stow first:"
        echo "  Ubuntu/Debian: sudo apt install stow"
        echo "  macOS:         brew install stow"
        echo "  Arch:          sudo pacman -S stow"
        exit 1
    fi
    print_success "GNU Stow found"
}

# Backup existing dotfiles
backup_existing() {
    local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    
    print_status "Checking for existing dotfiles..."
    
    local files_to_backup=(
        ".zshrc"
        ".tmux.conf" 
        ".aliases"
        ".config/nvim"
        ".config/ohmyposh"
    )
    
    local needs_backup=false
    for file in "${files_to_backup[@]}"; do
        if [[ -e "$HOME/$file" ]] && [[ ! -L "$HOME/$file" ]]; then
            if [[ "$needs_backup" == false ]]; then
                mkdir -p "$backup_dir"
                needs_backup=true
                print_warning "Found existing dotfiles, backing up to: $backup_dir"
            fi
            print_status "Backing up $file"
            cp -r "$HOME/$file" "$backup_dir/"
            rm -rf "$HOME/$file"
        fi
    done
    
    if [[ "$needs_backup" == true ]]; then
        print_success "Backup completed"
    else
        print_status "No backup needed"
    fi
}

# Install dotfiles using stow
install_dotfiles() {
    print_status "Installing dotfiles with stow..."
    
    # Change to dotfiles directory
    cd "$(dirname "$0")"
    
    # Stow all packages
    local packages=(
        "zsh"
        "tmux"
        "nvim"
        "shell"
        "ohmyposh"
    )
    
    for package in "${packages[@]}"; do
        if [[ -d "$package" ]]; then
            print_status "Stowing $package..."
            stow -v "$package"
            print_success "$package stowed successfully"
        else
            print_warning "Package $package not found, skipping..."
        fi
    done
}

# Set zsh as default shell (if not already set)
setup_zsh() {
    if [[ "$SHELL" != *"zsh"* ]]; then
        print_status "Setting zsh as default shell..."
        if command -v zsh &> /dev/null; then
            chsh -s $(which zsh)
            print_success "Default shell changed to zsh"
            print_warning "Please restart your terminal or run 'exec zsh' to use the new shell"
        else
            print_error "Zsh not found! Please install zsh first"
        fi
    else
        print_success "Zsh is already the default shell"
    fi
}

# Install zinit (zsh plugin manager) if not present
install_zinit() {
    local zinit_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
    
    if [[ ! -d "$zinit_dir" ]]; then
        print_status "Installing zinit..."
        mkdir -p "$(dirname "$zinit_dir")"
        git clone https://github.com/zdharma-continuum/zinit.git "$zinit_dir"
        print_success "Zinit installed successfully"
    else
        print_success "Zinit already installed"
    fi
}

# Main installation function
main() {
    print_status "Starting dotfiles installation..."
    echo
    
    check_stow
    backup_existing
    install_dotfiles
    setup_zsh
    install_zinit
    
    echo
    print_success "Dotfiles installation completed!"
    print_status "Next steps:"
    echo "  1. Restart your terminal or run 'exec zsh'"
    echo "  2. Your configurations will be loaded automatically"
    echo "  3. Check that all symlinks are working: ls -la ~/"
    echo
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi