import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkModeProvider = StateProvider<bool>((ref) {
  return false;
});

// final isDarkModeProvider =
//     StateNotifierProvider<ThemeChanger, ThemeData>((ref) => ThemeChanger());

// class ThemeChanger extends StateNotifier<ThemeData> {
//   ThemeChanger() : super(ThemeData());

//   Future<ThemeData> getTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final bool? isDarkMode = prefs.getBool('isDarkMode');

//     if (isDarkMode != null) {
//       if (isDarkMode) {
//         return ThemeData(
//           colorSchemeSeed: c.primary,
//           dividerColor: c.surface,
//           fontFamily: 'Poppins',
//           brightness: Brightness.dark,
//         );
//       } else {
//         return ThemeData(
//           colorSchemeSeed: c.primary,
//           dividerColor: c.surface,
//           fontFamily: 'Poppins',
//           brightness: Brightness.light,
//         );
//       }
//     } else {
//       return ThemeData(
//         colorSchemeSeed: c.primary,
//         dividerColor: c.surface,
//         fontFamily: 'Poppins',
//         brightness: Brightness.light,
//       );
//     }
//   }

//   ThemeData getDefaultTheme() {
//     return ThemeData(
//       colorSchemeSeed: c.primary,
//       dividerColor: c.surface,
//       fontFamily: 'Poppins',
//       brightness: Brightness.light,
//     );
//   }

//   Future<void> setTheme({required bool isDark}) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkMode', isDark);
//   }

//   // ThemeData setDefaultTheme() {
//   //   return ThemeData(
//   //     colorSchemeSeed: c.primary,
//   //     dividerColor: c.surface,
//   //     fontFamily: 'Poppins',
//   //     brightness: Brightness.light,
//   //   );
//   // }

//   // ThemeData setTheme({bool isDarkMode = false}) {
//   //   return isDarkMode
//   //       ? ThemeData(
//   //           colorSchemeSeed: c.primary,
//   //           // useMaterial3: true,
//   //           dividerColor: c.surface,
//   //           fontFamily: 'Poppins',
//   //           brightness: Brightness.dark,
//   //           // colorScheme: ColorScheme(
//   //           //   brightness: Brightness.dark,
//   //           //   primary: c.primary,
//   //           //   onPrimary: c.primary,
//   //           //   secondary: Colors.blue[700] ?? c.secondary,
//   //           //   onSecondary: c.onSecondaryDark,
//   //           //   error: c.error,
//   //           //   onError: c.error,
//   //           //   background: c.backgroundDark,
//   //           //   onBackground: c.backgroundDark,
//   //           //   surface: c.backgroundDark,
//   //           //   onSurface: c.background.withOpacity(0.9),
//   //           // ),
//   //         )
//   //       : ThemeData(
//   //           colorSchemeSeed: c.primary,
//   //           // useMaterial3: true,
//   //           dividerColor: c.surface,
//   //           fontFamily: 'Poppins',
//   //           brightness: Brightness.light,
//   //           // colorScheme: ColorScheme(
//   //           //   brightness: Brightness.light,
//   //           //   primary: c.primary,
//   //           //   onPrimary: c.primary,
//   //           //   secondary: Colors.blue[700] ?? c.secondary,
//   //           //   onSecondary: c.onSecondary,
//   //           //   error: c.error,
//   //           //   onError: c.error,
//   //           //   background: c.background,
//   //           //   onBackground: c.background,
//   //           //   surface: c.background,
//   //           //   onSurface: c.black.withOpacity(0.9),
//   //           // ),
//   //         );
//   // }
// }
