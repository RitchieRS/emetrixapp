import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class GradientTitle extends ConsumerWidget {
  const GradientTitle(
      {super.key,
      required this.height,
      required this.width,
      required this.title1,
      required this.title2});
  final double height;
  final double width;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: const [0.1, 0.5],
        colors: [c.secondary, c.primary.withOpacity(0.55)],
      )),
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(title1, style: t.textLight),
            Text(title2, style: t.titleWhite),
          ],
        ),
      ),
    );
  }
}
