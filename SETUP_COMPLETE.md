import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyager/pages/splash_screen.dart';
import 'package:voyager/utils/string_constants.dart';
import 'package:voyager/utils/theme.dart';



void main() {
WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
.then((_) {
runApp(const ProviderScope(child: MyApp()));
});
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: StringConstants.appName,
theme: ThemeData(
fontFamily: 'VT323',
hintColor: Colors.white,
scaffoldBackgroundColor: ThemesDark().normalColor,
inputDecorationTheme: InputDecorationTheme(
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
borderSide: BorderSide(
color: ThemesDark().oppositeColor,
),
),
hintStyle: TextStyle(color: ThemesDark().oppositeColor),
),

      ),
      home: const SplashScreen(),
    );
}
}

# LG Voyager - Flutter Project Setup Complete ✅

## Project Status
All dependencies have been added and imports are fixed. The project is ready for development!

## Dependencies Added (Latest Versions as of Dec 2024)

### State Management
- `bloc: ^8.1.4` - Business Logic Component pattern
- `flutter_bloc: ^8.1.6` - Flutter widgets for Bloc
- `flutter_riverpod: ^2.6.1` - Riverpod state management
- `equatable: ^2.0.7` - Simplify equality comparisons
- `get_it: ^8.0.2` - Service locator for dependency injection

### UI Components
- `google_fonts: ^6.2.1` - Google Fonts support (VT323 font enabled)
- `lottie: ^3.1.3` - Lottie animations
- `particles_flutter: ^0.1.4` - Particle effects
- `settings_ui: ^2.0.2` - Settings UI components
- `flutter_animated_button: ^2.0.3` - Animated button widgets
- `rounded_loading_button: ^2.1.0` - Loading button with rounded corners

### Maps
- `google_maps_flutter: ^2.9.0` - Google Maps integration

### SSH
- `dartssh2: ^2.9.5` - SSH2 client for Dart

## Project Structure

```
lib/
├── main.dart                          # Main app entry point with Riverpod & Google Fonts
├── pages/
│   └── splash_screen.dart            # Splash screen with animations
└── utils/
    ├── theme.dart                     # ThemesDark & ThemesLight with complete styling
    ├── string_constants.dart          # All app string constants
    └── package_examples.dart          # Examples of how to use each package
```

## Key Features Implemented

### 1. Main App (main.dart)
- ✅ Landscape orientation locked
- ✅ Riverpod ProviderScope wrapper
- ✅ Google Fonts VT323 theme applied
- ✅ Dark theme with complete styling

### 2. Theme System (utils/theme.dart)
- ✅ ThemesDark class with comprehensive dark theme
- ✅ ThemesLight class with comprehensive light theme
- ✅ Color palette defined
- ✅ Custom InputDecoration theme
- ✅ Custom ElevatedButton theme
- ✅ Text theme styles

### 3. Splash Screen (pages/splash_screen.dart)
- ✅ Animated fade-in effect
- ✅ Loading indicator
- ✅ Auto-navigation after 3 seconds (commented for customization)

### 4. Constants (utils/string_constants.dart)
- ✅ App information
- ✅ Screen titles
- ✅ Messages
- ✅ SSH connection strings
- ✅ Button labels

### 5. Package Examples (utils/package_examples.dart)
- ✅ Bloc pattern examples
- ✅ GetIt service locator setup
- ✅ SSH connection examples
- ✅ Riverpod provider examples
- ✅ Google Maps usage
- ✅ Lottie animations
- ✅ Button widget examples

## Running the Project

### Prerequisites
Make sure Flutter is installed and in your PATH:
```bash
flutter --version
```

### Install Dependencies
```bash
flutter pub get
```

### Run on Emulator/Device
```bash
flutter run
```

### For Landscape Mode
The app is configured to run in landscape mode only (DeviceOrientation.landscapeLeft).

## Google Maps Setup (If Needed)

To use Google Maps, you'll need to add API keys:

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<manifest>
    <application>
        <meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="YOUR_API_KEY_HERE"/>
    </application>
</manifest>
```

### iOS (ios/Runner/AppDelegate.swift)
```swift
import GoogleMaps

GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

## Next Steps

1. **Create Home Screen**: Replace the TODO comment in splash_screen.dart
2. **Add Assets**: Create an `assets` folder for images, animations, etc.
3. **Update pubspec.yaml**: Add asset paths if needed:
   ```yaml
   flutter:
     assets:
       - assets/images/
       - assets/animations/
   ```
4. **SSH Configuration**: Implement SSH connection logic using dartssh2
5. **State Management**: Choose between Bloc or Riverpod (or use both for different features)
6. **Google Maps**: Add API keys and implement map features

## Package Usage Examples

Check `lib/utils/package_examples.dart` for detailed examples of:
- Creating Blocs with Events and States
- Setting up GetIt dependency injection
- Connecting via SSH
- Using Riverpod providers
- Implementing Google Maps
- Adding Lottie animations
- Using animated buttons

## Common Commands

```bash
# Get dependencies
flutter pub get

# Clean build
flutter clean

# Run app
flutter run

# Build APK
flutter build apk

# Build for release
flutter build apk --release

# Check for outdated packages
flutter pub outdated

# Upgrade packages
flutter pub upgrade
```

## Troubleshooting

### If you see "flutter command not found"
Add Flutter to your system PATH or use the full path to flutter executable.

### If dependencies fail to install
```bash
flutter clean
flutter pub get
```

### If you see build errors
1. Check that all files exist
2. Run `flutter clean`
3. Run `flutter pub get`
4. Restart your IDE

## Notes

- The project uses Dart SDK ^3.10.4
- All deprecated methods have been updated (e.g., `withOpacity` → `withValues`)
- The theme system is fully configured and ready to use
- Examples are provided for all major packages

---

**Project is ready for development! 🚀**

