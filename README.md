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

You can add the asset generator to your project with a single command. Open your terminal in the **root directory of your Flutter project** and run:

```sh
# IMPORTANT: Replace YourUsername/YourRepo with your actual GitHub username and repository name.
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/YourUsername/YourRepo/main/install.sh](https://raw.githubusercontent.com/YourUsername/YourRepo/main/install.sh))"
```

This command will:
1.  Create a `scripts/` directory in your project.
2.  Download the `generate_assets.sh` script into it.
3.  Make the script executable.

It's highly recommended to commit the `scripts` folder to your version control system so your entire team can use it.

---

## 🏃‍♀️ Usage

1.  **Add assets** to your `assets` folder as you normally would (e.g., `assets/images/logo.png`).
2.  **Declare them** in your `pubspec.yaml` file to make them available to your app.
3.  **Run the script** from your project's root directory:

    ```sh
    ./scripts/generate_assets.sh
    ```

The script will generate (or overwrite) the file at `lib/constants/app_assets.dart` with your new asset constants.

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
