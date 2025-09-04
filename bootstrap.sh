#!/bin/bash

# Bootstrap script for setting up development environment on ubuntutools2
# This script installs all necessary dependencies and sets up dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_REPO="https://github.com/mukilteowa-gov/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
NODE_VERSION="24.3.0"  # Match your current version
NEOVIM_VERSION="stable"

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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update system packages
update_system() {
    print_status "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    print_success "System updated"
}

# Install basic dependencies
install_system_deps() {
    print_status "Installing system dependencies..."
    
    local packages=(
        "curl"
        "wget"
        "git"
        "stow"
        "zsh"
        "tmux"
        "build-essential"
        "software-properties-common"
        "apt-transport-https"
        "ca-certificates"
        "gnupg"
        "lsb-release"
        "unzip"
        "ripgrep"
        "fd-find"
        "tree"
        "htop"
        "jq"
        "python3"
        "python3-pip"
        "python3-venv"
        "fzf"
        "bat"
        "pkg-config"
        "libssl-dev"
    )
    
    sudo apt install -y "${packages[@]}"
    print_success "System dependencies installed"
}

# Install Docker
install_docker() {
    if command_exists docker; then
        print_success "Docker already installed"
        return
    fi
    
    print_status "Installing Docker..."
    
    # Add Docker's official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # Set up repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Install Docker
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    # Add user to docker group
    sudo usermod -aG docker "$USER"
    
    print_success "Docker installed (you may need to log out and back in)"
}

# Install Docker Compose (standalone)
install_docker_compose() {
    if command_exists docker-compose; then
        print_success "Docker Compose already installed"
        return
    fi
    
    print_status "Installing Docker Compose..."
    
    local latest_version
    latest_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
    
    sudo curl -L "https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    print_success "Docker Compose installed"
}

# Install NVM and Node.js
install_node() {
    if command_exists node && [[ "$(node --version)" == "v$NODE_VERSION" ]]; then
        print_success "Node.js $NODE_VERSION already installed"
        return
    fi
    
    print_status "Installing NVM and Node.js $NODE_VERSION..."
    
    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    
    # Source NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Install and use Node.js
    nvm install "$NODE_VERSION"
    nvm use "$NODE_VERSION"
    nvm alias default "$NODE_VERSION"
    
    print_success "Node.js $NODE_VERSION installed"
}

# Install pnpm
install_pnpm() {
    if command_exists pnpm; then
        print_success "pnpm already installed"
        return
    fi
    
    print_status "Installing pnpm..."
    
    # Install pnpm
    curl -fsSL https://get.pnpm.io/install.sh | sh -
    
    # Add to PATH
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
    
    print_success "pnpm installed"
}

# Install Neovim
install_neovim() {
    if command_exists nvim; then
        print_success "Neovim already installed"
        return
    fi
    
    print_status "Installing Neovim..."
    
    # Download and install Neovim
    cd /tmp
    wget "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    sudo tar -xzf nvim-linux-x86_64.tar.gz -C /opt
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    
    print_success "Neovim installed"
}

# Install Oh My Posh
install_oh_my_posh() {
    if command_exists oh-my-posh; then
        print_success "Oh My Posh already installed"
        return
    fi
    
    print_status "Installing Oh My Posh..."
    
    curl -s https://ohmyposh.dev/install.sh | bash -s
    
    print_success "Oh My Posh installed"
}

# Install Lazygit
install_lazygit() {
    if command_exists lazygit; then
        print_success "Lazygit already installed"
        return
    fi
    
    print_status "Installing Lazygit..."
    
    local LAZYGIT_VERSION
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    
    cd /tmp
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -f lazygit.tar.gz lazygit
    
    print_success "Lazygit installed"
}

# Install Rust (optional but useful for many tools)
install_rust() {
    if command_exists rustc; then
        print_success "Rust already installed"
        return
    fi
    
    print_status "Installing Rust..."
    
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    
    print_success "Rust installed"
}

# Clone dotfiles repository
clone_dotfiles() {
    if [[ -d "$DOTFILES_DIR" ]]; then
        print_status "Dotfiles directory exists, pulling latest changes..."
        cd "$DOTFILES_DIR"
        git pull
    else
        print_status "Cloning dotfiles repository..."
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
    
    print_success "Dotfiles repository ready"
}

# Install dotfiles using our install script
install_dotfiles() {
    print_status "Installing dotfiles..."
    
    cd "$DOTFILES_DIR"
    chmod +x install.sh
    ./install.sh
    
    print_success "Dotfiles installed"
}

# Set zsh as default shell
setup_zsh() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        print_success "Zsh already set as default shell"
        return
    fi
    
    print_status "Setting zsh as default shell..."
    chsh -s $(which zsh)
    print_success "Default shell changed to zsh"
}

# Install additional useful tools
install_additional_tools() {
    print_status "Installing additional development tools..."
    
    # Create bat symlink if needed (Ubuntu installs as batcat)
    if command_exists batcat && ! command_exists bat; then
        mkdir -p ~/.local/bin
        ln -sf /usr/bin/batcat ~/.local/bin/bat
        print_success "Created bat symlink"
    fi
    
    # Install cargo tools if cargo is available
    if command_exists cargo; then
        # Install eza (better ls)
        if ! command_exists eza; then
            print_status "Installing eza via cargo..."
            cargo install eza
            print_success "eza installed"
        else
            print_success "eza already installed"
        fi
        
        # Install delta (better git diff)
        if ! command_exists delta; then
            print_status "Installing delta via cargo..."
            cargo install git-delta
            print_success "delta installed"
        else
            print_success "delta already installed"
        fi
        
        # Install zoxide if not already installed (better cd)
        if ! command_exists zoxide; then
            print_status "Installing zoxide via cargo..."
            cargo install zoxide
            print_success "zoxide installed"
        else
            print_success "zoxide already installed"
        fi
    else
        print_warning "Cargo not available, skipping Rust tools installation"
    fi
    
    print_success "Additional tools processed"
}

# Final setup and verification
verify_installation() {
    print_status "Verifying installation..."
    
    local tools=(
        "git"
        "stow"
        "zsh"
        "tmux"
        "node"
        "npm"
        "pnpm"
        "nvim"
        "docker"
        "docker-compose"
        "oh-my-posh"
        "python3"
        "pip3"
    )
    
    local missing_tools=()
    
    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then
            print_success "$tool: $(command -v "$tool")"
        else
            missing_tools+=("$tool")
            print_warning "$tool: not found"
        fi
    done
    
    if [[ ${#missing_tools[@]} -eq 0 ]]; then
        print_success "All tools installed successfully!"
    else
        print_warning "Some tools are missing: ${missing_tools[*]}"
    fi
}

# Main bootstrap function
main() {
    print_status "Starting bootstrap process for development environment..."
    echo
    
    print_status "This script will install:"
    echo "  - System dependencies (git, curl, build tools, etc.)"
    echo "  - Docker & Docker Compose"
    echo "  - Node.js $NODE_VERSION via NVM"
    echo "  - pnpm package manager"
    echo "  - Neovim latest"
    echo "  - Oh My Posh prompt"
    echo "  - Rust toolchain"
    echo "  - Additional dev tools"
    echo "  - Your dotfiles configuration"
    echo
    
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Bootstrap cancelled"
        exit 0
    fi
    
    echo
    print_status "Starting installation..."
    
    update_system
    install_system_deps
    install_docker
    install_docker_compose
    install_node
    install_pnpm
    install_neovim
    install_oh_my_posh
    install_lazygit
    install_rust
    clone_dotfiles
    install_dotfiles
    setup_zsh
    install_additional_tools
    verify_installation
    
    echo
    print_success "Bootstrap completed successfully!"
    print_status "Next steps:"
    echo "  1. Log out and back in (or run 'newgrp docker' for Docker access)"
    echo "  2. Start a new zsh session: exec zsh"
    echo "  3. Your development environment is ready!"
    echo
    print_warning "Note: Some tools may require a shell restart to work properly"
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi