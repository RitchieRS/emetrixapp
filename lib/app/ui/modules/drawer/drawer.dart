import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/drawer/menu_items.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  int? currentIndex;

  navigate(String link) {
    Future.delayed(const Duration(milliseconds: 400)).whenComplete(() {
      Navigator.pushNamed(context, link);
      Scaffold.of(context).closeDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final color = c.primary200;

    return NavigationDrawer(
        selectedIndex: currentIndex,
        indicatorColor: color,
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
              decoration: BoxDecoration(color: c.surface),
              child: CircleAvatar(
                  backgroundColor:
                      isDark == ThemeMode.dark ? color.withOpacity(0.7) : color,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(AppAssets.logo),
                  )),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: Text('Principales', style: t.text2),
          ),

          // ...appMenuItems.sublist(0, 4).map((item) =>
          ...appMenuItems.map((item) => NavigationDrawerDestination(
              icon: item.icon, label: Text(item.title, style: t.text2))),

          // Padding(
          //   padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          //   child: Text('Secundarias', style: t.text2),
          // ),

          // ...appMenuItems.sublist(4).map((item) => NavigationDrawerDestination(
          //     icon: item.icon, label: Text(item.title, style: t.text2))),

          //
        ]);
  }
}

//---

void showRoutes(BuildContext context, Size size) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.02, bottom: size.height * 0.01),
              child: Text('Menú', style: t.subtitle),
            ),
            SizedBox(
              height: size.height * 0.35,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: appMenuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = appMenuItems[index];

                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, menuItem.link);
                    },
                    leading: Icon(menuItem.icon.icon, color: c.primary500),
                    title: Text(menuItem.title),
                  );
                },
              ),
            )
          ],
        );
      });
}
