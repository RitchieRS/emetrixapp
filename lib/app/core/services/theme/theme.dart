import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system) {
    loadThemeFromPrefs();
  }

  Future<void> loadThemeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }

  Future<void> toggleTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      await prefs.setBool('isDarkMode', false);
    } else {
      state = ThemeMode.dark;
      await prefs.setBool('isDarkMode', true);
    }
  }

  Future<void> setLightTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = ThemeMode.light;
    await prefs.setBool('isDarkMode', false);
  }

  Future<void> setDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = ThemeMode.dark;
    await prefs.setBool('isDarkMode', true);
  }

  //
}
