import 'package:emetrix_flutter/app/ui/home/home.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/route_of_the_day.dart';
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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomePage(),
      // const AditionalActivitiesPage(),
      const RouteOfTheDayPage(),
      // const PendingsPage(),
      const SettingsPage(),
    ];

    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          elevation: 0,
          selectedItemColor: c.primary,
          unselectedItemColor: c.disabled.withOpacity(0.5),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.alt_route), label: 'Fuera de Ruta'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.task_outlined), label: 'Adicionales'),
            BottomNavigationBarItem(
                icon: Icon(Icons.route), label: 'Ruta del dia'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.task), label: 'Pendientes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Ajustes'),
          ],
        ));
  }
}
