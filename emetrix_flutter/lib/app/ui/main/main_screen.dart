import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/out_of_route.dart';
import 'package:emetrix_flutter/app/ui/settings/settings.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MainPage> {
  // int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    Services.checkConectivity();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);
    List<Widget> screens = [
      const OutOfRoutePage(),
      const SettingsPage(),
    ];

    return Scaffold(
        // body: screens[ref.watch(mainIndex)],
        body: IndexedStack(
          index: ref.watch(mainIndex),
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ref.watch(mainIndex),
          onTap: (value) => ref.read(mainIndex.notifier).setIndex(value),
          elevation: 0,
          selectedItemColor: c.primary,
          unselectedItemColor: isDark == ThemeMode.dark
              ? c.background.withOpacity(0.4)
              : c.disabled.withOpacity(0.5),
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.alt_route), label: 'Fuera de Ruta'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Ajustes'),
          ],
        ));
  }
}
