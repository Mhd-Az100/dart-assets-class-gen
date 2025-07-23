# Flutter Asset Generator Script 🚀

A simple but powerful bash script that automates the creation of a Dart `Assets` class from your Flutter project's `assets` folder. Say goodbye to string-based asset paths and hello to type-safe, autocompleted constants!

This script helps you write cleaner, more maintainable code by eliminating the risk of typos and runtime errors when referencing assets.

---

## ✨ Features

-   **Type-Safe Assets**: Generates a Dart class with `static const` strings for each asset.
-   **Auto-Generated**: Runs from your terminal to scan your asset directory.
-   **Organized & Ordered**: Groups assets by their parent folder (e.g., `images`, `icons`) and then by file extension (`.svg`, `.png`, etc.).
-   **Smart Naming**: Creates logical camelCase variable names from file paths (e.g., `assets/images/onboarding_welcome.png` becomes `imagesOnboardingWelcome`).
-   **Customizable**: Easily change the source directory, output file, and class name.

---

## ⚙️ Installation

Install the script as a global command with a single line in your terminal. This will allow you to run it from any directory.

```sh
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/Mhd-Az100/dart-assets-class-gen/main/install.sh](https://raw.githubusercontent.com/Mhd-Az100/dart-assets-class-gen/main/install.sh))"
```
After installation, you may need to **restart your terminal** or run `source ~/.bashrc` (or `~/.zshrc`) for the new command to be available.

---
## 🏃‍♀️ Usage

Once installed, you can generate your assets class from the root of **any** Flutter project with a simple command:

```sh
generate-flutter-assets
```

The script will automatically find your `assets` folder and generate the `app_assets.dart` file inside `lib/constants/`.

### In Your Dart Code

Now, you can access your assets safely in your Flutter widgets:

```dart
// 1. Import the generated file
import 'package:your_project/constants/app_assets.dart'; // Adjust the import path if needed

// 2. Use the constants
Image.asset(AppAssets.imagesLogo);

// Example with flutter_svg
// import 'package:flutter_svg/flutter_svg.dart';
// SvgPicture.asset(AppAssets.iconsHome);
```

---

## 🔧 Configuration

You can customize the script's behavior by editing the configuration variables at the top of the `scripts/generate_assets.sh` file:

```bash
# --- Configuration ---
ASSETS_DIR="assets"
OUTPUT_FILE="lib/constants/app_assets.dart"
CLASS_NAME="AppAssets"
```

---

## 📄 License

This project is licensed under the MIT License.
