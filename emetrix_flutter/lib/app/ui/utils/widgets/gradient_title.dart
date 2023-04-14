import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class GradientTitle extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.only(top: size.height * 0.035),
        child: AppBar(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title1, style: t.textLight),
                Text(title2, style: t.titleLight),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: c.background),
            centerTitle: true),
      ),
    );
  }
}
