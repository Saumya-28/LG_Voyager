import 'package:flutter/material.dart';

class ThemesDark {
  // Colors
  final Color normalColor = const Color(0xFF0D0D0D);
  final Color oppositeColor = const Color(0xFFFFFFFF);
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFF26A69A);
  final Color accentColor = const Color(0xFFFF6F00);
  final Color errorColor = const Color(0xFFD32F2F);
  final Color successColor = const Color(0xFF388E3C);
  final Color warningColor = const Color(0xFFFFA000);

  // Text Colors
  final Color textPrimaryColor = const Color(0xFFFFFFFF);
  final Color textSecondaryColor = const Color(0xFFB0B0B0);
  final Color textDisabledColor = const Color(0xFF707070);

  // Background Colors
  final Color backgroundColor = const Color(0xFF0D0D0D);
  final Color surfaceColor = const Color(0xFF1A1A1A);
  final Color cardColor = const Color(0xFF242424);

  // Border Colors
  final Color borderColor = const Color(0xFF404040);
  final Color dividerColor = const Color(0xFF2A2A2A);

  // Button Colors
  final Color buttonColor = const Color(0xFF1E88E5);
  final Color buttonDisabledColor = const Color(0xFF505050);

  // Tab Bar Color
  final Color tabBarColor = const Color(0xFF1A1A1A);

  // Create ThemeData
  ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: normalColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: oppositeColor,
        onSecondary: oppositeColor,
        onSurface: textPrimaryColor,
        onError: oppositeColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: normalColor,
        foregroundColor: oppositeColor,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textPrimaryColor, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: textPrimaryColor, fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: textPrimaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: textPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: textPrimaryColor, fontSize: 16, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: textPrimaryColor, fontSize: 14),
        bodyMedium: TextStyle(color: textSecondaryColor, fontSize: 12),
        bodySmall: TextStyle(color: textDisabledColor, fontSize: 10),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: errorColor),
        ),
        hintStyle: TextStyle(color: textSecondaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: oppositeColor,
          disabledBackgroundColor: buttonDisabledColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class ThemesLight {
  // Colors
  final Color normalColor = const Color(0xFFFFFFFF);
  final Color oppositeColor = const Color(0xFF0D0D0D);
  final Color primaryColor = const Color(0xFF1976D2);
  final Color secondaryColor = const Color(0xFF00897B);
  final Color accentColor = const Color(0xFFFF6F00);
  final Color errorColor = const Color(0xFFD32F2F);
  final Color successColor = const Color(0xFF388E3C);
  final Color warningColor = const Color(0xFFFFA000);

  // Text Colors
  final Color textPrimaryColor = const Color(0xFF0D0D0D);
  final Color textSecondaryColor = const Color(0xFF5F5F5F);
  final Color textDisabledColor = const Color(0xFFB0B0B0);

  // Background Colors
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color surfaceColor = const Color(0xFFF5F5F5);
  final Color cardColor = const Color(0xFFFFFFFF);

  // Border Colors
  final Color borderColor = const Color(0xFFE0E0E0);
  final Color dividerColor = const Color(0xFFE0E0E0);

  // Button Colors
  final Color buttonColor = const Color(0xFF1976D2);
  final Color buttonDisabledColor = const Color(0xFFE0E0E0);

  // Tab Bar Color
  final Color tabBarColor = const Color(0xFFF5F5F5);

  // Create ThemeData
  ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: normalColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: oppositeColor,
        onSecondary: oppositeColor,
        onSurface: textPrimaryColor,
        onError: oppositeColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: oppositeColor,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textPrimaryColor, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: textPrimaryColor, fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: textPrimaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: textPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: textPrimaryColor, fontSize: 16, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: textPrimaryColor, fontSize: 14),
        bodyMedium: TextStyle(color: textSecondaryColor, fontSize: 12),
        bodySmall: TextStyle(color: textDisabledColor, fontSize: 10),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: errorColor),
        ),
        hintStyle: TextStyle(color: textSecondaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: oppositeColor,
          disabledBackgroundColor: buttonDisabledColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

