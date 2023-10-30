import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/route_of_the_day.dart';
import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/settings/settings.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MainPage> {
  List<Widget> screens = [
    const RouteOfTheDayPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    Services.checkConectivity(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final indexMain = ref.watch(mainIndex);
    final unselectedColor = Theme.of(context).textTheme.bodyLarge?.color;

    return
        // DefaultTabController(
        //   length: screens.length,
        //   child:
        Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: c.surface,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark),
      ),
      drawer: const MyDrawer(),
      body: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: IndexedStack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          index: ref.watch(mainIndex),
          children: screens,
        ),
      ),

      //         TabBarView(
      //       physics: const BouncingScrollPhysics(),
      //       children: screens,
      //     ),
      bottomNavigationBar:
          // TabBar(
          //       enableFeedback: true,
          //       automaticIndicatorColorAdjustment: true,
          //       indicatorColor: c.primary500,
          //       unselectedLabelColor: isDark
          //           ? c.background.withOpacity(0.3)
          //           : c.disabled.withOpacity(0.5),
          //       labelColor: isDark == ThemeMode.dark ? c.background : c.black,
          //       padding: const EdgeInsets.all(0),
          //       tabs: const [
          //         Tab(
          //           icon: Icon(Icons.alt_route),
          //           text: 'Ruta del dia',
          //           height: 60,
          //           iconMargin: EdgeInsets.all(5),
          //         ),
          //         Tab(
          //           icon: Icon(Icons.settings),
          //           text: 'Ajustes',
          //           height: 60,
          //           iconMargin: EdgeInsets.all(5),
          //         ),
          //       ],
          //     ),
          //   ),
          // );

          //     NavigationBar(
          //   selectedIndex: indexMain,
          //   onDestinationSelected: (int index) =>
          //       ref.read(mainIndex.notifier).setIndex(index),
          //   indicatorColor: c.primary200,
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //   destinations: [
          //     NavigationDestination(
          //       selectedIcon:
          //           Icon(Icons.alt_route, color: isDark ? c.black : c.primary500),
          //       icon: Icon(Icons.alt_route,
          //           color: isDark ? c.black : c.disabled.withOpacity(0.5)),
          //       label: 'Ruta del dia',
          //     ),
          //     NavigationDestination(
          //       selectedIcon:
          //           Icon(Icons.settings, color: isDark ? c.black : c.primary500),
          //       icon: Icon(Icons.settings,
          //           color: isDark ? c.black : c.disabled.withOpacity(0.5)),
          //       label: 'Ajustes',
          //     ),
          //   ],
          // ),

          SalomonBottomBar(
        currentIndex: indexMain,
        onTap: (int index) => ref.read(mainIndex.notifier).setIndex(index),
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.route_outlined),
              activeIcon: const Icon(Icons.route),
              title: const Text("Ruta del dia"),
              selectedColor: c.primary500,
              unselectedColor: unselectedColor),
          SalomonBottomBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              title: const Text("Ajustes"),
              selectedColor: c.primary500,
              unselectedColor: unselectedColor),
        ],
      ),

      //     BottomNavigationBar(
      //   currentIndex: indexMain,
      //   onTap: (value) => ref.read(mainIndex.notifier).setIndex(value),
      //   elevation: 0,
      //   selectedItemColor: c.primary500,
      //   unselectedItemColor: isDark
      //       ? c.background.withOpacity(0.4)
      //       : c.disabled.withOpacity(0.5),
      //   showUnselectedLabels: true,
      //   selectedFontSize: 12,
      //   unselectedFontSize: 12,
      //   enableFeedback: true,
      //   selectedLabelStyle: t.text,
      //   unselectedLabelStyle: t.text,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.alt_route),
      //       label: 'Ruta del dia',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Ajustes',
      //     ),
      //   ],
      // )
    );
  }
}
