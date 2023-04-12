import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/core/routes.dart';
import 'package:emetrix_flutter/app/ui/splash/splash.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: const SplashPage(), //Splash or Home
        debugShowCheckedModeBanner: false,
        routes: getAppRoutes(),

        //Set theme of the app before enter to the app. The configuration be saved in storage
        theme: Services.setTheme(isDarkMode: false));
  }
}
