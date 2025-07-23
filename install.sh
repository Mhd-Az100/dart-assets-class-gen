#!/bin/bash

# Flutter Asset Generator Installer
# Installs the asset generator script globally for the current user.
# Version: 2.0.0

set -e

# --- Configuration ---
SCRIPT_NAME="generate-flutter-assets"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_URL="https://raw.githubusercontent.com/Mhd-Az100/dart-assets-class-gen/refs/heads/main/generate_assets.sh"
UNINSTALLER_NAME="uninstall-flutter-assets"

# --- Colors for Output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# --- Logging Functions ---
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_step() { echo -e "\n${PURPLE}▸ $1${NC}"; }

# --- Banner ---
print_banner() {
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║                                                        ║"
    echo "║       Global Flutter Asset Generator Installer         ║"
    echo "║                                                        ║"
    echo "║   ✨ Create type-safe asset constants from anywhere    ║"
    echo "║                                                        ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# --- Helper Functions ---
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_requirements() {
    log_step "Checking requirements..."
    if ! command_exists curl && ! command_exists wget; then
        log_error "Either 'curl' or 'wget' is required to download the script."
        exit 1
    fi
    log_success "Requirements met."
}

# --- Core Functions ---
create_install_dir() {
    log_step "Ensuring installation directory exists..."
    if [ ! -d "$INSTALL_DIR" ]; then
        mkdir -p "$INSTALL_DIR"
        log_info "Created directory: $INSTALL_DIR"
    else
        log_info "Directory already exists: $INSTALL_DIR"
    fi
}

install_script() {
    log_step "Installing Asset Generator script..."
    local target_path="$INSTALL_DIR/$SCRIPT_NAME"
    
    log_info "Downloading script from GitHub..."
    if command_exists curl; then
        if ! curl -fsSL "$SCRIPT_URL" -o "$target_path"; then
            log_error "Download failed using curl. Please check the URL and your connection."
            exit 1
        fi
    else
        if ! wget -q "$SCRIPT_URL" -O "$target_path"; then
            log_error "Download failed using wget. Please check the URL and your connection."
            exit 1
        fi
    fi

    chmod +x "$target_path"
    log_success "Script installed successfully to: $target_path"
}

update_path() {
    log_step "Checking system PATH..."
    if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]]; then
        log_info "Installation directory is already in your PATH."
        return
    fi
    
    log_warning "Installation directory not found in PATH. Attempting to update shell configuration."
    local shell_config=""
    if [ -n "$BASH_VERSION" ]; then
        shell_config="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        shell_config="$HOME/.zshrc"
    else
        shell_config="$HOME/.profile"
    fi

    if [ -f "$shell_config" ]; then
        echo "" >> "$shell_config"
        echo "# Added by Flutter Asset Generator Installer" >> "$shell_config"
        echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$shell_config"
        log_success "Added PATH to $shell_config."
        log_warning "Please restart your terminal or run 'source $shell_config' to apply changes."
    else
        log_error "Could not find a shell config file. Please add '$INSTALL_DIR' to your PATH manually."
    fi
}

create_uninstaller() {
    log_step "Creating uninstaller..."
    local uninstaller_path="$INSTALL_DIR/$UNINSTALLER_NAME"
    
    cat > "$uninstaller_path" << EOF
#!/bin/bash
echo "🗑️  Uninstalling Flutter Asset Generator..."
rm -f "$INSTALL_DIR/$SCRIPT_NAME"
rm -f "$uninstaller_path"
echo "✅ Uninstalled successfully."
echo "ℹ️  You may need to manually remove the PATH entry from your shell configuration file (e.g., ~/.bashrc or ~/.zshrc)."
EOF

    chmod +x "$uninstaller_path"
    log_success "Uninstaller created. Run '$UNINSTALLER_NAME' to remove."
}

print_summary() {
    echo -e "\n${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║             🎉 Installation Complete!                 ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}🚀 HOW TO USE:${NC}"
    echo "   1. Navigate to any Flutter project root directory."
    echo "   2. Run the global command:"
    echo -e "      ${YELLOW}$SCRIPT_NAME${NC}"
    echo ""
    echo -e "${CYAN}📦 UNINSTALL:${NC}"
    echo "   To remove the script, run:"
    echo -e "      ${YELLOW}$UNINSTALLER_NAME${NC}"
    echo ""
    echo -e "${GREEN}Happy coding! ✨${NC}"
}

# --- Main Logic ---
main() {
    print_banner
    
    if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
        log_warning "Asset Generator is already installed."
        read -p "Do you want to reinstall? (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installation cancelled."
            exit 0
        fi
    fi
    
    check_requirements
    create_install_dir
    install_script
    update_path
    create_uninstaller
    print_summary
}

# --- Argument Parsing ---
case "${1:-}" in
    --help|-h)
        echo "Flutter Asset Generator Installer"
        echo "Usage: ./install.sh [COMMAND]"
        echo ""
        echo "Commands:"
        echo "  (no command)      Run the interactive global installer."
        echo "  --uninstall       Remove the globally installed tool."
        echo "  --help, -h        Show this help message."
        ;;
    --uninstall)
        if [ -f "$INSTALL_DIR/$UNINSTALLER_NAME" ]; then
             exec "$INSTALL_DIR/$UNINSTALLER_NAME"
        else
            log_error "Uninstaller not found. The tool may not be installed."
            exit 1
        fi
        ;;
    *)
        main
        ;;
esac
