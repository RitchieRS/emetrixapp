import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class GradientTitle extends ConsumerWidget implements PreferredSizeWidget {
  const GradientTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return AppBar(
      backgroundColor: c.surface,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
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
