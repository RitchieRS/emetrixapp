import 'package:emetrix_flutter/app/ui/home/home.dart';
import 'package:emetrix_flutter/app/ui/pendings/pendings.dart';
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
    final screens = [const HomePage(), const PendingsPage()];

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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.route), label: 'Ruta del dia'),
            BottomNavigationBarItem(
                icon: Icon(Icons.task), label: 'Pendientes'),
          ],
        ));
  }
}
