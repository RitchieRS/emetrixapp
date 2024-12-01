import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class AppTheme {
  AppTheme();

  static ThemeData ligthTheme() {
    return ThemeData(
      // useMaterial3: true,
      dividerColor: c.surface,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: c.primary500,
        primary: c.primary500,
      ),
      // primaryColor: c.primary,
      brightness: Brightness.light,
      navigationDrawerTheme: NavigationDrawerThemeData(
        indicatorColor: c.primary500,
        labelTextStyle: MaterialStatePropertyAll(
            TextStyle(fontFamily: 'Poppins', fontSize: 12, color: c.black)),
      ),
      navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
      ))),
      iconTheme: IconThemeData(color: c.background),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
        // useMaterial3: true,
        primaryColor: c.primary500,
        dividerColor: c.surface,
        // scaffoldBackgroundColor: const Color(0xFF2C2C2C),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: c.primary500,
        ),
        navigationDrawerTheme: NavigationDrawerThemeData(
            indicatorColor: c.primary500,
            labelTextStyle: MaterialStatePropertyAll(TextStyle(
                fontFamily: 'Poppins', fontSize: 12, color: c.background))),
        navigationBarTheme: const NavigationBarThemeData(
            labelTextStyle: MaterialStatePropertyAll(TextStyle(
          fontFamily: 'Poppins',
        ))),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedIconTheme:
              IconThemeData(color: c.background.withOpacity(0.4)),
        ));
  }
}
