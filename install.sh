#!/bin/bash

# Flutter Asset Generator Installer
# Installs the asset generator script locally into a Flutter project.
# Version: 1.1.0

set -e

# --- Configuration ---
SCRIPT_URL="https://raw.githubusercontent.com/Mhd-Az100/dart-assets-class-gen/refs/heads/main/generate_assets.sh"
SCRIPT_DIR="scripts"
SCRIPT_NAME="generate_assets.sh"
TARGET_PATH="$SCRIPT_DIR/$SCRIPT_NAME"

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
    echo "║          Flutter Asset Generator Installer             ║"
    echo "║                                                        ║"
    echo "║   ✨ Create type-safe asset constants automatically    ║"
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
install_script() {
    log_step "Installing Asset Generator script..."
    
    if [ ! -d "$SCRIPT_DIR" ]; then
        mkdir -p "$SCRIPT_DIR"
        log_info "Created directory: $SCRIPT_DIR"
    fi

    log_info "Downloading script from GitHub..."
    if command_exists curl; then
        if ! curl -fsSL "$SCRIPT_URL" -o "$TARGET_PATH"; then
            log_error "Download failed using curl. Please check the URL and your connection."
            exit 1
        fi
    elif command_exists wget; then
        if ! wget -q "$SCRIPT_URL" -O "$TARGET_PATH"; then
            log_error "Download failed using wget. Please check the URL and your connection."
            exit 1
        fi
    fi

    chmod +x "$TARGET_PATH"
    log_success "Script installed successfully to: $TARGET_PATH"
}

uninstall_script() {
    echo ""
    log_warning "This will remove the 'scripts' directory and all its contents."
    read -p "Are you sure you want to uninstall? (y/N): " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ -d "$SCRIPT_DIR" ]; then
            rm -rf "$SCRIPT_DIR"
            log_success "Flutter Asset Generator has been uninstalled."
        else
            log_info "Directory '$SCRIPT_DIR' not found. Nothing to uninstall."
        fi
    else
        log_info "Uninstallation cancelled."
    fi
}

print_summary() {
    echo -e "\n${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║             🎉 Installation Complete!                 ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}🚀 HOW TO USE:${NC}"
    echo "   1. Add your assets to your project (e.g., 'assets/images/')."
    echo "   2. Declare them in 'pubspec.yaml'."
    echo "   3. Run the generator from your project root:"
    echo -e "      ${YELLOW}./$TARGET_PATH${NC}"
    echo ""
    echo -e "${CYAN}📦 UNINSTALL:${NC}"
    echo "   To remove the script, run:"
    echo -e "      ${YELLOW}./install.sh --uninstall${NC}"
    echo ""
    echo -e "${GREEN}Happy coding! ✨${NC}"
}

# --- Main Logic ---
main() {
    print_banner
    
    if [ -f "$TARGET_PATH" ]; then
        log_warning "Asset Generator is already installed."
        read -p "Do you want to reinstall? (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installation cancelled."
            exit 0
        fi
    fi
    
    check_requirements
    install_script
    print_summary
}

# --- Argument Parsing ---
case "${1:-}" in
    --help|-h)
        echo "Flutter Asset Generator Installer"
        echo "Usage: ./install.sh [COMMAND]"
        echo ""
        echo "Commands:"
        echo "  (no command)      Run the interactive installer."
        echo "  --uninstall       Remove the generator script and 'scripts' directory."
        echo "  --help, -h        Show this help message."
        ;;
    --uninstall)
        uninstall_script
        ;;
    *)
        main
        ;;
esac
