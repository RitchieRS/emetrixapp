import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:emetrix_flutter/app/core/routes.dart';
import 'package:emetrix_flutter/app/ui/splash/splash.dart';

import 'app/ui/utils/utils.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);

    return GetMaterialApp(
        home: const SplashPage(), //Splash or Home
        debugShowCheckedModeBanner: false,
        routes: getAppRoutes(),

        //Set theme of the app before enter to the app. The configuration be saved in storage
        theme: isDark
            ? ThemeData(
                colorSchemeSeed: c.primary,
                dividerColor: c.surface,
                fontFamily: 'Poppins',
                brightness: Brightness.dark,
              )
            : ThemeData(
                // colorSchemeSeed: c.primary,
                dividerColor: c.surface,
                fontFamily: 'Poppins',
                brightness: Brightness.light,
                primaryColor: c.primary,
                iconTheme: IconThemeData(color: c.background),
              ));
  }
}
