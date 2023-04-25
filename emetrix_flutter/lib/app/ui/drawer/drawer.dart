import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/drawer/menu_items.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  int currentIndex = 0;

  navigate(String link) {
    Future.delayed(const Duration(milliseconds: 400)).whenComplete(() {
      Navigator.pushNamed(context, link);
      Scaffold.of(context).closeDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });

          final menuItem = appMenuItems[value];
          menuItem.link.isNotEmpty ? navigate(menuItem.link) : null;
        },
        children: [
          Padding(
            padding: EdgeInsets.only(top: hasNotch ? 5 : 15),
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(AppAssets.logo),
                  )),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Principales'),
          ),

          ...appMenuItems.sublist(0, 4).map((item) =>
              NavigationDrawerDestination(
                  icon: item.icon, label: Text(item.title))),

          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Secundarias'),
          ),

          ...appMenuItems.sublist(4).map((item) => NavigationDrawerDestination(
              icon: item.icon, label: Text(item.title))),

          //
        ]);
  }
}
