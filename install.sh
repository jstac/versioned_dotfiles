#!/bin/bash
#
# Dotfiles Installation Script
# Usage: ./install.sh [--skip-sudo] [--skip-builds]
#
# Options:
#   --skip-sudo    Skip steps requiring sudo (useful if already done)
#   --skip-builds  Skip building from source (Yazi, etc.)

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
SKIP_SUDO=false
SKIP_BUILDS=false
for arg in "$@"; do
    case $arg in
        --skip-sudo) SKIP_SUDO=true ;;
        --skip-builds) SKIP_BUILDS=true ;;
        *) echo "Unknown argument: $arg"; exit 1 ;;
    esac
done

# Helper functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_command() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

prompt_sudo() {
    if [ "$SKIP_SUDO" = true ]; then
        log_warn "Skipping sudo task: $1"
        return 1
    fi
    echo -e "${YELLOW}The following step requires sudo:${NC}"
    echo "  $1"
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_warn "Skipped: $1"
        return 1
    fi
    return 0
}

# ============================================================================
# Phase 1: System Package Installation (requires sudo)
# ============================================================================

install_apt_packages() {
    log_info "Phase 1: Installing system packages via apt"

    if prompt_sudo "Install apt packages (rofi, kitty, zsh, git, etc.)"; then
        sudo apt update
        sudo apt install -y \
            rofi kitty suckless-tools bat zsh git chromium \
            fd-find fzf gnome-tweaks ripgrep zoxide \
            build-essential zathura tmux \
            p7zip-full librsvg2-bin poppler-utils \
            curl wget
        log_success "System packages installed"
    fi
}

# ============================================================================
# Phase 2: Install Rust and Cargo Tools
# ============================================================================

install_rust() {
    log_info "Phase 2: Installing Rust and cargo tools"

    if check_command cargo; then
        log_success "Rust/Cargo already installed ($(cargo --version))"
    else
        log_info "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        log_success "Rust installed"
    fi

    # Ensure cargo is in PATH for this session
    export PATH="$HOME/.cargo/bin:$PATH"

    log_info "Installing cargo packages: eza, git-delta, vivid, tree-sitter-cli"
    cargo install eza git-delta vivid tree-sitter-cli
    log_success "Cargo tools installed"
}

# ============================================================================
# Phase 3: Build Tools from Source
# ============================================================================

build_yazi() {
    log_info "Phase 3: Building Yazi from source"

    if [ "$SKIP_BUILDS" = true ]; then
        log_warn "Skipping Yazi build (--skip-builds flag set)"
        return
    fi

    if check_command yazi; then
        log_success "Yazi already installed ($(yazi --version))"
        return
    fi

    log_info "Cloning and building Yazi..."
    cd ~
    if [ ! -d "yazi" ]; then
        git clone https://github.com/sxyazi/yazi.git
    fi
    cd yazi
    cargo build --release --locked

    if prompt_sudo "Move Yazi binaries to /usr/local/bin"; then
        sudo mv target/release/yazi target/release/ya /usr/local/bin/
        log_success "Yazi installed to /usr/local/bin"
    else
        log_warn "Yazi built but not installed. Binaries at: ~/yazi/target/release/{yazi,ya}"
    fi
    cd ~
}

# ============================================================================
# Phase 4: Install Starship Prompt (requires sudo)
# ============================================================================

install_starship() {
    log_info "Phase 4: Installing Starship prompt"

    if check_command starship; then
        log_success "Starship already installed ($(starship --version))"
        return
    fi

    if prompt_sudo "Install Starship prompt"; then
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        log_success "Starship installed"
    fi
}

# ============================================================================
# Phase 5: Install Bitwarden CLI (requires sudo)
# ============================================================================

install_bitwarden_cli() {
    log_info "Phase 5: Installing Bitwarden CLI"

    if check_command bw; then
        log_success "Bitwarden CLI already installed ($(bw --version))"
        return
    fi

    if ! check_command npm; then
        log_error "npm not found. Please install Node.js and npm first."
        log_error "See README.md for instructions."
        return
    fi

    if prompt_sudo "Install Bitwarden CLI via npm"; then
        sudo npm install -g @bitwarden/cli
        log_success "Bitwarden CLI installed"
    fi
}

# ============================================================================
# Phase 6: Nerd Fonts Installation
# ============================================================================

install_nerd_fonts() {
    log_info "Phase 6: Installing Nerd Fonts"

    if [ ! -d "$HOME/Downloads" ] || [ -z "$(ls -A $HOME/Downloads/*.zip 2>/dev/null)" ]; then
        log_warn "No font zip files found in ~/Downloads"
        log_warn "Please download Nerd Fonts from https://www.nerdfonts.com/font-downloads"
        log_warn "Recommended: FiraCode, FiraMono, Hack, CascadiaCode"
        return
    fi

    mkdir -p ~/.local/share/fonts

    log_info "Extracting Nerd Fonts from ~/Downloads..."
    for font_zip in ~/Downloads/*.zip; do
        [ -f "$font_zip" ] || continue
        log_info "Extracting $(basename "$font_zip")..."
        unzip -o "$font_zip" -d ~/.local/share/fonts 2>&1 | grep -v "inflating:" || true
    done

    log_info "Rebuilding font cache..."
    fc-cache -fv > /dev/null 2>&1
    log_success "Nerd Fonts installed"
}

# ============================================================================
# Phase 7: Git Configuration
# ============================================================================

configure_git() {
    log_info "Phase 7: Configuring git"

    # Check if already configured
    if git config --global user.email &> /dev/null; then
        log_success "Git already configured ($(git config --global user.name) <$(git config --global user.email)>)"
        return
    fi

    # Prompt for user details
    read -p "Enter your git user.name: " git_name
    read -p "Enter your git user.email: " git_email

    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global credential.helper "cache --timeout=8640000"

    log_success "Git configured"
}

# ============================================================================
# Phase 8: Dotfile Symlinks
# ============================================================================

setup_dotfile_symlinks() {
    log_info "Phase 8: Setting up dotfile symlinks"

    DOTFILES_DIR="$HOME/gh_synced/versioned_dotfiles"

    if [ ! -d "$DOTFILES_DIR" ]; then
        log_error "Dotfiles directory not found: $DOTFILES_DIR"
        log_error "Please clone versioned_dotfiles to ~/gh_synced/ first"
        return
    fi

    # Backup existing dotfiles
    [ -f ~/.zshrc ] && mv ~/.zshrc /tmp/.zshrc.backup.$(date +%s) 2>/dev/null || true
    [ -f ~/.zshenv ] && mv ~/.zshenv /tmp/.zshenv.backup.$(date +%s) 2>/dev/null || true

    # Top-level symlinks
    log_info "Creating top-level symlinks..."
    ln -sf "$DOTFILES_DIR/top_level/zshenv" ~/.zshenv
    ln -sf "$DOTFILES_DIR/top_level/latexmkrc" ~/.latexmkrc

    # ~/.config/zsh setup
    log_info "Setting up zsh configuration..."
    mkdir -p ~/.config/zsh/plugins
    ln -sf "$DOTFILES_DIR/dot_config/zsh/zshrc" ~/.config/zsh/.zshrc

    # Clone zsh plugins if not present
    if [ ! -d ~/.config/zsh/plugins/fast-syntax-highlighting ]; then
        log_info "Cloning fast-syntax-highlighting..."
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting \
            ~/.config/zsh/plugins/fast-syntax-highlighting
    fi

    if [ ! -d ~/.config/zsh/plugins/zsh-vi-mode ]; then
        log_info "Cloning zsh-vi-mode..."
        git clone https://github.com/jeffreytse/zsh-vi-mode \
            ~/.config/zsh/plugins/zsh-vi-mode
    fi

    # Create zsh cache/data directories
    mkdir -p ~/.cache/zsh
    mkdir -p ~/.local/share/zsh

    # ~/.config symlinks
    log_info "Creating ~/.config symlinks..."
    cd ~/.config
    ln -sf "$DOTFILES_DIR/dot_config/starship.toml" .
    ln -sf "$DOTFILES_DIR/dot_config/kitty" .
    ln -sf "$DOTFILES_DIR/dot_config/nvim" .
    ln -sf "$DOTFILES_DIR/dot_config/yazi" .
    ln -sf "$DOTFILES_DIR/dot_config/zathura" .
    ln -sf "$DOTFILES_DIR/dot_config/tmux/tmux.conf" .
    cd - > /dev/null

    log_success "Dotfile symlinks created"
}

# ============================================================================
# Phase 9: Versioned Tools Setup
# ============================================================================

setup_versioned_tools() {
    log_info "Phase 9: Setting up versioned_tools"

    TOOLS_DIR="$HOME/gh_synced/versioned_tools"

    if [ ! -d "$TOOLS_DIR" ]; then
        log_info "Cloning versioned_tools..."
        cd ~/gh_synced
        if ! git clone https://github.com/jstac/versioned_tools; then
            log_warn "Failed to clone versioned_tools (may require GitHub auth)"
            log_warn "Please clone manually: cd ~/gh_synced && git clone https://github.com/jstac/versioned_tools"
            return
        fi
    fi

    # Create bin directory and symlinks
    mkdir -p ~/bin
    mkdir -p ~/backups/rsync_dir_backup

    log_info "Creating symlinks in ~/bin..."
    cd ~/bin
    for script in check_sync photoresize pull_sync push_sync; do
        if [ -f "$TOOLS_DIR/$script" ]; then
            ln -sf "$TOOLS_DIR/$script" .
        fi
    done
    cd - > /dev/null

    log_success "versioned_tools set up"
}

# ============================================================================
# Phase 10: Directory Cleanup
# ============================================================================

cleanup_directories() {
    log_info "Phase 10: Cleaning up default directories"

    # Check which directories exist
    DIRS_TO_MOVE=()
    for dir in Music Pictures Public Videos Templates Documents; do
        if [ -d "$HOME/$dir" ]; then
            DIRS_TO_MOVE+=("$dir")
        fi
    done

    if [ ${#DIRS_TO_MOVE[@]} -eq 0 ]; then
        log_success "Default directories already cleaned up"
        return
    fi

    echo -e "${YELLOW}The following directories will be moved to /tmp:${NC}"
    for dir in "${DIRS_TO_MOVE[@]}"; do
        echo "  - ~/$dir"
    done
    read -p "Move these directories to /tmp? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_warn "Skipped directory cleanup"
        return
    fi

    for dir in "${DIRS_TO_MOVE[@]}"; do
        mv "$HOME/$dir" /tmp/
        log_info "Moved ~/$dir to /tmp"
    done

    log_success "Default directories cleaned up"
}

# ============================================================================
# Phase 11: SSH Key Setup
# ============================================================================

setup_ssh_keys() {
    log_info "Phase 11: SSH key setup"

    # Check if SSH key already exists
    if [ -f "$HOME/.ssh/id_rsa" ]; then
        log_success "SSH key already exists"
        return
    fi

    echo -e "${YELLOW}Generate SSH key for remote access?${NC}"
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_warn "Skipped SSH key setup"
        return
    fi

    log_info "Generating RSA SSH key..."
    ssh-keygen -t rsa

    log_info "Starting ssh-agent and adding key..."
    eval "$(ssh-agent -s)"
    ssh-add

    log_success "SSH key generated and added to agent"
    echo -e "${BLUE}Public key location: ~/.ssh/id_rsa.pub${NC}"
    echo -e "${BLUE}To copy to remote: ssh-copy-id -i ~/.ssh/id_rsa user@host${NC}"
}

# ============================================================================
# Phase 12: Post-Install Instructions
# ============================================================================

show_post_install_instructions() {
    log_info "=========================================="
    log_info "Installation Complete!"
    log_info "=========================================="
    echo
    log_warn "Manual steps remaining (see README.md for details):"
    echo
    echo "1. Change default shell to zsh:"
    echo "   $ chsh -s /bin/zsh"
    echo "   Then log out and log back in."
    echo
    echo "2. Configure keyboard shortcuts in gnome-tweaks:"
    echo "   - Caps Lock → Ctrl (Keyboard → Additional Layout Options)"
    echo "   - Alt+d → rofi -show drun"
    echo "   - Alt+Enter → /usr/bin/kitty"
    echo
    echo "3. Set keyboard mapping (run after login):"
    echo "   $ setxkbmap -option \"ctrl:nocaps\""
    echo
    echo "4. Optional: Install Anaconda for Python development"
    echo "   See README.md for instructions"
    echo
    log_success "Enjoy your new setup!"
}

# ============================================================================
# Main Installation Flow
# ============================================================================

main() {
    log_info "Starting dotfiles installation..."
    echo

    install_apt_packages
    install_rust
    build_yazi
    install_starship
    install_bitwarden_cli
    install_nerd_fonts
    configure_git
    setup_dotfile_symlinks
    setup_versioned_tools
    cleanup_directories
    setup_ssh_keys

    echo
    show_post_install_instructions
}

# Run main installation
main
