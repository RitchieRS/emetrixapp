import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class AppTheme {
  AppTheme();

  static ThemeData ligthTheme() {
    return ThemeData(
      dividerColor: c.surface,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: c.primary,
        primary: c.primary,
      ),
      // primaryColor: c.primary,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: c.background),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
        primaryColor: c.primary,
        dividerColor: c.surface,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: c.primary,
        ),
        navigationDrawerTheme: NavigationDrawerThemeData(
          indicatorColor: c.primary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedIconTheme:
              IconThemeData(color: c.background.withOpacity(0.4)),
        ));
  }
}
