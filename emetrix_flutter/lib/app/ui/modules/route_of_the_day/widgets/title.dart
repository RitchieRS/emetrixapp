import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTitle extends ConsumerWidget implements PreferredSizeWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, color: c.primary)),
        title: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('RUTA', style: t.titleBlue),
            Text('Del Dia', style: t.textBlue),
          ],
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: c.primary),
        centerTitle: true,
        toolbarHeight: Dimentions().getHeight() * 0.12,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: c.surface,
            statusBarIconBrightness:
                isDark == ThemeMode.dark ? Brightness.light : Brightness.dark));
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimentions().getHeight() * 0.12);
}
