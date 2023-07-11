import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTitle extends ConsumerWidget implements PreferredSizeWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = ref.watch(themeProvider);

    return AppBar(
      backgroundColor: c.surface,
      title: Text(title ?? '', style: t.medium),
      centerTitle: true,
      elevation: 0,
      foregroundColor: Theme.of(context).hintColor,
      toolbarHeight: size.height * 0.07,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: c.surface,
        statusBarIconBrightness:
            theme == ThemeMode.light ? Brightness.dark : Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
