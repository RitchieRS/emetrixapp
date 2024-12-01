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
    this.subtitle = '',
  });
  final String title;
  final String subtitle;
  final bool showMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return AppBar(
      leading: showMenu
          ? IconButton(
              // onPressed: () => Scaffold.of(context).openDrawer(),
              onPressed: () => showRoutes(context, size),
              icon: Icon(Icons.menu, color: isDark ? c.onSecondary : c.black))
          : null,
      backgroundColor: c.surface,
      elevation: 0,
      systemOverlayStyle:
          !isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      toolbarHeight: size.height * 0.1,
      foregroundColor: isDark ? c.onSecondary : c.black,
      centerTitle: true,
      title: Column(
        children: [
          Text(title,
              style: isDark ? t.titleWhite : t.titleBlack,
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
          Text(subtitle, style: t.textDisabled, maxLines: 1),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimentions().getHeight() * 0.1);
}
