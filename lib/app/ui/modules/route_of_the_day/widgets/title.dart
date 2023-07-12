import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MyTitle extends ConsumerWidget implements PreferredSizeWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final size = MediaQuery.of(context).size;

    return AppBar(
      leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.menu,
              color: isDark == ThemeMode.dark ? c.onSecondary : c.black)),
      centerTitle: true,
      title: Text('Ruta del Dia',
          style: isDark == ThemeMode.dark ? t.titleWhite : t.titleBlack),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(color: c.primary),
      toolbarHeight: size.height * 0.1,
      systemOverlayStyle: isDark == ThemeMode.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    );
  }

  // String currentTime() {
  //   final hour = DateTime.now().hour;

  //   if (hour >= 5 && hour <= 12) {
  //     return '¡Buenos Días! ☀';
  //   }
  //   if (hour >= 13 && hour <= 19) {
  //     return '¡Buenas Tardes! ⛅';
  //   }
  //   return '¡Buenas Noches! 🌙';
  // }

  @override
  Size get preferredSize => Size.fromHeight(Dimentions().getHeight() * 0.1);
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // Size get preferredSize => Size.fromHeight(Dimentions().getHeight() * 0.06);
}
