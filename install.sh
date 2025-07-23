#!/bin/bash
#
# This script downloads and sets up the Flutter asset generator script
# from a GitHub repository into the user's local project.

# --- Configuration ---
# IMPORTANT: Replace this URL with the raw content link to your `generate_assets.sh` file on GitHub.
# To get the link: Go to the file on GitHub -> Click "Raw".
REPO_URL="https://raw.githubusercontent.com/Mhd-Az100/dart-assets-class-gen/refs/heads/main/generate_assets.sh"

SCRIPT_DIR="scripts"
SCRIPT_NAME="generate_assets.sh"
TARGET_PATH="$SCRIPT_DIR/$SCRIPT_NAME"

# --- Installation Process ---
echo "⚙️  Setting up Flutter Asset Generator..."

# 1. Create the scripts directory if it doesn't exist.
echo "-> Creating directory: $SCRIPT_DIR/"
mkdir -p "$SCRIPT_DIR"

# 2. Download the script using curl. Fallback to wget if curl is not available.
echo "-> Downloading script from GitHub..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL -o "$TARGET_PATH" "$REPO_URL"
else
  wget -q -O "$TARGET_PATH" "$REPO_URL"
fi

# 3. Check if the download was successful.
if [ ! -s "$TARGET_PATH" ]; then
    echo "❌ Error: Failed to download the script. Please check the URL in the install script and your internet connection."
    exit 1
fi

# 4. Make the script executable.
echo "-> Making script executable..."
chmod +x "$TARGET_PATH"

# --- Finish ---
echo ""
echo "✅ Setup complete!"
echo "The asset generator is now at: $TARGET_PATH"
echo ""
echo "To run it, use the following command from your project root:"
echo "   ./$TARGET_PATH"
echo ""
echo "It's recommended to commit the '$SCRIPT_DIR/' folder to your version control."
