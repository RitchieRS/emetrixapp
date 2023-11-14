import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class GeneralTitle extends ConsumerWidget implements PreferredSizeWidget {
  const GeneralTitle({
    super.key,
    required this.title,
    this.showMenu = false,
  });
  final String title;
  final bool showMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return AppBar(
      leading: showMenu
          ? IconButton(
              // onPressed: () => Scaffold.of(context).openDrawer(),
              onPressed: () => showRoutes(context, size),
              icon: Icon(Icons.menu,
                  color: isDark == ThemeMode.dark ? c.onSecondary : c.black))
          : null,
      backgroundColor: c.surface,
      elevation: 0,
      systemOverlayStyle: isDark == ThemeMode.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      toolbarHeight: size.height * 0.1,
      foregroundColor: isDark == ThemeMode.dark ? c.onSecondary : c.black,
      centerTitle: true,
      title: Text(title,
          style: isDark == ThemeMode.dark ? t.titleWhite : t.titleBlack,
          overflow: TextOverflow.ellipsis,
          maxLines: 1),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimentions().getHeight() * 0.1);
}
