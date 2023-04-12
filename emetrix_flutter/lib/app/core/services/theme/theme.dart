import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class ThemeChanger {
  ThemeData setDefaultTheme() {
    return ThemeData(
      // colorSchemeSeed: c.primary,
      // useMaterial3: true,
      dividerColor: c.surface,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: c.primary,
        onPrimary: c.primary,
        secondary: Colors.blue[700] ?? c.secondary,
        onSecondary: c.onSecondary,
        error: c.error,
        onError: c.error,
        background: c.background,
        onBackground: c.background,
        surface: c.background,
        onSurface: c.black.withOpacity(0.9),
      ),
    );
  }

  ThemeData setTheme({bool isDarkMode = false}) {
    return isDarkMode
        ? ThemeData(
            // colorSchemeSeed: c.primary,
            // useMaterial3: true,
            dividerColor: c.surface,
            fontFamily: 'Poppins',
            colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: c.primary,
              onPrimary: c.primary,
              secondary: Colors.blue[700] ?? c.secondary,
              onSecondary: c.onSecondaryDark,
              error: c.error,
              onError: c.error,
              background: c.backgroundDark,
              onBackground: c.backgroundDark,
              surface: c.backgroundDark,
              onSurface: c.background.withOpacity(0.9),
            ),
          )
        : ThemeData(
            // colorSchemeSeed: c.primary,
            // useMaterial3: true,
            dividerColor: c.surface,
            fontFamily: 'Poppins',
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: c.primary,
              onPrimary: c.primary,
              secondary: Colors.blue[700] ?? c.secondary,
              onSecondary: c.onSecondary,
              error: c.error,
              onError: c.error,
              background: c.background,
              onBackground: c.background,
              surface: c.background,
              onSurface: c.black.withOpacity(0.9),
            ),
          );
  }
}
