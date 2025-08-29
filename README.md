# 🏠 Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) for consistent development environment setup across machines.

## 📦 What's Included

- **Zsh** configuration with [Zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- **Tmux** configuration with [Catppuccin](https://github.com/catppuccin/tmux) theme
- **Tmuxinator** project layout configurations
- **Neovim** configuration 
- **Oh My Posh** prompt theme
- **Git** configuration and global gitignore
- **Bash** configuration for fallback shell
- **GitHub CLI** settings
- **Shell aliases** and utilities
- **Local scripts** and PATH management
- Development environment setup scripts

## 🚀 Quick Start

### For Existing Systems (Local Install)

```bash
# Clone this repository
git clone https://github.com/mukilteowa-gov/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install using stow
./install.sh
```

### For New Systems (Bootstrap)

For setting up a complete development environment (like on ubuntutools2):

```bash
# Download and run the bootstrap script
curl -fsSL https://raw.githubusercontent.com/mukilteowa-gov/dotfiles/master/bootstrap.sh | bash
```

Or manually:

```bash
wget https://raw.githubusercontent.com/mukilteowa-gov/dotfiles/master/bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

## 📋 Prerequisites

### For Local Install Only
- [GNU Stow](https://www.gnu.org/software/stow/)
- Git

### For Bootstrap (Installs Everything)
- Ubuntu/Debian system with sudo access
- Internet connection
- Git (will be installed if missing)

## 🗂️ Repository Structure

```
dotfiles/
├── install.sh          # Local installation script using stow
├── bootstrap.sh        # Full system setup script for new machines
├── README.md           # This file
├── zsh/                # Zsh configuration
│   └── .zshrc
├── tmux/               # Tmux configuration
│   ├── .tmux.conf
│   └── .tmux/          # Tmux plugins and themes
├── tmuxinator/         # Tmux project layouts
│   └── .config/
│       └── tmuxinator/
│           ├── work.yml
│           ├── home.yml
│           └── ...
├── nvim/               # Neovim configuration
│   └── .config/
│       └── nvim/
├── git/                # Git configuration
│   ├── .gitconfig
│   └── .gitignore_global
├── bash/               # Bash configuration
│   ├── .bashrc
│   └── .profile
├── gh/                 # GitHub CLI configuration
│   └── .config/
│       └── gh/
│           └── config.yml
├── bin/                # Local scripts
│   └── .local/
│       └── bin/
│           └── env
├── shell/              # Shell aliases and utilities
│   ├── .aliases
│   └── claude-badge.sh
├── ohmyposh/           # Oh My Posh configuration
│   └── .config/
│       └── ohmyposh/
│           └── zen.toml
└── notes/              # Documentation and notes
    └── ...
```

## 🔧 Manual Installation

If you prefer to install manually:

1. **Install dependencies:**
   ```bash
   # Ubuntu/Debian
   sudo apt install stow git zsh tmux

   # macOS
   brew install stow git zsh tmux
   ```

2. **Clone repository:**
   ```bash
   git clone https://github.com/mukilteowa-gov/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

3. **Stow individual packages:**
   ```bash
   stow zsh        # Install zsh configuration
   stow tmux       # Install tmux configuration
   stow tmuxinator # Install tmux project layouts
   stow nvim       # Install neovim configuration
   stow git        # Install git configuration
   stow bash       # Install bash configuration
   stow gh         # Install GitHub CLI settings
   stow bin        # Install local scripts
   stow shell      # Install shell aliases
   stow ohmyposh   # Install oh-my-posh theme
   ```

4. **Set zsh as default shell:**
   ```bash
   chsh -s $(which zsh)
   ```

5. **Install zsh plugin manager (Zinit):**
   ```bash
   mkdir -p ~/.local/share/zinit
   git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
   ```

## 🛠️ Development Tools Included

The bootstrap script installs:

### System Tools
- Git, curl, wget, build-essential
- GNU Stow for dotfiles management
- Ripgrep, fd-find for fast searching
- Tree, htop, jq for system utilities

### Development Environment
- **Node.js** (v24.3.0) via NVM
- **pnpm** package manager
- **Python 3** with pip
- **Docker** & Docker Compose
- **Neovim** (latest stable)
- **Rust** toolchain

### Terminal Enhancement
- **Zsh** with Zinit plugin manager
- **Tmux** with Catppuccin theme
- **Oh My Posh** for beautiful prompts
- **Bat** (better cat)
- **Eza** (better ls)
- **Delta** (better git diff)

## 🎨 Customization

### Zsh Configuration
The zsh config includes:
- Zinit plugin manager
- History optimization
- Auto-completion setup
- Path configuration for various tools

### Tmux Configuration  
- Catppuccin Frappe theme
- Custom key bindings
- Plugin support
- Mouse support enabled

### Aliases
Check `shell/.aliases` for available shortcuts and commands.

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull
stow --restow zsh tmux tmuxinator nvim git bash gh bin shell ohmyposh
```

## 🐛 Troubleshooting

### Stow Conflicts
If stow reports conflicts:
```bash
# Remove existing files and try again
rm ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.bashrc  # etc.
stow zsh tmux tmuxinator nvim git bash gh bin shell ohmyposh
```

### Zsh Not Loading
Make sure zsh is your default shell:
```bash
echo $SHELL  # Should show /usr/bin/zsh or /bin/zsh
chsh -s $(which zsh)
```

### Tmux Plugins Not Loading
Install tmux plugin manager:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# In tmux: prefix + I to install plugins
```

### Permission Issues
Make sure scripts are executable:
```bash
chmod +x ~/dotfiles/install.sh
chmod +x ~/dotfiles/bootstrap.sh
```

## 📚 Additional Notes

- The bootstrap script is designed for Ubuntu/Debian systems
- All configurations follow XDG base directory specifications where possible
- Backup of existing dotfiles is created automatically during installation
- The setup includes development tools commonly used in modern workflows

## 🤝 Usage for ubuntutools2

To sync your environment to ubuntutools2:

1. **SSH into ubuntutools2**
2. **Run the bootstrap script:**
   ```bash
   bash <(curl -fsSL https://raw.githubusercontent.com/mukilteowa-gov/dotfiles/master/bootstrap.sh)
   ```
3. **Log out and back in** to activate all changes
4. **Verify installation** with the tools listed in the script output

The bootstrap process will:
- Install all development dependencies
- Set up your exact shell and terminal configuration  
- Configure all development tools to match your local environment
- Create identical working environment across both machines

## 📄 License

This is a personal dotfiles repository. Feel free to fork and adapt for your own use.

---

*Generated with ❤️ using GNU Stow*