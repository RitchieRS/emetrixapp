import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/routes.dart';
import 'package:emetrix_flutter/app/ui/splash/splash.dart';

import 'app/ui/utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return GetMaterialApp(
      home: const SplashPage(), //Splash or Home
      debugShowCheckedModeBanner: false,
      routes: getAppRoutes(),
      defaultTransition: Transition.fadeIn,

      //Set theme of the app before enter to the app. The configuration be saved in storage
      theme: ThemeData(
        dividerColor: c.surface,
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        primaryColor: c.primary,
        iconTheme: IconThemeData(color: c.background),
      ),
      darkTheme: ThemeData(
        primaryColor: c.primary,
        dividerColor: c.surface,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        navigationDrawerTheme: NavigationDrawerThemeData(
          indicatorColor: c.primary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedIconTheme:
              IconThemeData(color: c.background.withOpacity(0.4)),
        )

        //
        ,
      ),

      themeMode: isDark == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
