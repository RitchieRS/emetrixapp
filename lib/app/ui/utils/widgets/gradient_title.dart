import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class GradientTitle extends ConsumerWidget implements PreferredSizeWidget {
  const GradientTitle({
    super.key,
    required this.preferedSize,
    required this.title,
  });
  final Size preferedSize;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: c.secondary,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      toolbarHeight: preferedSize.height,
      centerTitle: true,
      title: Text(title,
          style: t.titleWhite, overflow: TextOverflow.ellipsis, maxLines: 1),
    );
  }

  @override
  Size get preferredSize => preferedSize;
}
