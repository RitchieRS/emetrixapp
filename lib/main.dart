import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/core/global/routes.dart';
import 'package:emetrix_flutter/app/ui/modules/splash/splash.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
      home: const SplashPage(), //Splash or Home
      debugShowCheckedModeBanner: false,
      routes: appRoutes(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
      ],
      theme: AppTheme.ligthTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: isDark == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
