import 'package:emetrix_flutter/app/ui/splash/splash.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(), //Splash or Home
      debugShowCheckedModeBanner: false,

      //Theme of the app
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: c.primary,
              onPrimary: c.primary,
              secondary: c.secondary,
              onSecondary: c.onSecondary,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.transparent,
              onBackground: Colors.transparent,
              surface: Colors.transparent,
              onSurface: Colors.transparent)),
    );
  }
}
