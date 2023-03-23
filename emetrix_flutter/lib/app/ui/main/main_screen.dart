import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/out_of_route.dart';
import 'package:emetrix_flutter/app/ui/settings/settings.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MainPage> {
  // int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const OutOfRoutePage(),
      const SettingsPage(),
    ];

    return Scaffold(
        body: IndexedStack(
          index: ref.watch(mainIndex),
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ref.watch(mainIndex),
          onTap: (value) => ref.read(mainIndex.notifier).setIndex(value),
          elevation: 0,
          selectedItemColor: c.primary,
          unselectedItemColor: c.disabled.withOpacity(0.5),
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
