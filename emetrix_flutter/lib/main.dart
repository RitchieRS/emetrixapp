import 'package:emetrix_flutter/app/ui/splash/splash.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/core/services/main.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
  Services.checkConectivity();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashPage(), //Splash or Home
      debugShowCheckedModeBanner: false,

      //Theme of the app
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: c.primary,
            onPrimary: c.primary,
            secondary: c.secondary,
            onSecondary: c.onSecondary,
            error: c.error,
            onError: c.error,
            background: c.background,
            onBackground: c.background,
            surface: c.background,
            onSurface: c.black.withOpacity(0.9),
          )),
    );
  }
}
